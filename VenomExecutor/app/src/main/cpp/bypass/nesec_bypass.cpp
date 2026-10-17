// nesec_bypass.cpp
// Hedef lib: libnesec.so (NetEase Security SDK)
// Strateji:
//   1. libnesec.so load edilmeden önce sahte bir "libnesec.so" belleğe aç (dlopen trick)
//   2. JNI_OnLoad intercept - nesec init fonksiyonuna sahte JNIEnv döndür
//   3. /proc/self/maps üzerinden libnesec.so'nun base adresini bul, kritik check fonksiyonlarını NOP'la
//   4. libnesec.so'nun obfuscated export'unun return değerini patch et

#include "nesec_bypass.h"
#include <jni.h>
#include <android/log.h>
#include <dlfcn.h>
#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <pthread.h>
#include <unistd.h>
#include <fcntl.h>
#include <elf.h>

#define LOG_TAG "VenomNesec"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)

typedef void* (*orig_dlopen_t)(const char* filename, int flag);
typedef void* (*orig_dlsym_t)(void* handle, const char* symbol);

static orig_dlopen_t orig_dlopen = nullptr;
static orig_dlsym_t orig_dlsym = nullptr;

static bool nesec_patched = false;

static uintptr_t find_lib_base(const char* libname) {
    FILE* maps = fopen("/proc/self/maps", "r");
    if (!maps) return 0;

    char line[512];
    uintptr_t base = 0;
    while (fgets(line, sizeof(line), maps)) {
        if (strstr(line, libname) != nullptr && strstr(line, "r-xp") != nullptr) {
            base = (uintptr_t)strtoul(line, nullptr, 16);
            break;
        }
    }
    fclose(maps);
    return base;
}

static size_t find_lib_size(uintptr_t base) {
    char maps_path[64];
    snprintf(maps_path, sizeof(maps_path), "/proc/self/maps");
    FILE* maps = fopen(maps_path, "r");
    if (!maps) return 0;

    char line[512];
    uintptr_t end = 0;
    while (fgets(line, sizeof(line), maps)) {
        if (strstr(line, "libnesec.so") != nullptr) {
            uintptr_t seg_start = (uintptr_t)strtoul(line, nullptr, 16);
            char* dash = strchr(line, '-');
            if (dash) {
                uintptr_t seg_end = (uintptr_t)strtoul(dash + 1, nullptr, 16);
                if (seg_end > end) end = seg_end;
            }
        }
    }
    fclose(maps);
    return (end > base) ? (end - base) : 0;
}

static void patch_memory(void* addr, const uint8_t* patch, size_t len) {
    uintptr_t page_start = ((uintptr_t)addr) & ~(getpagesize() - 1);
    size_t page_len = (((uintptr_t)addr + len - page_start) + getpagesize() - 1) & ~(getpagesize() - 1);

    if (mprotect((void*)page_start, page_len, PROT_READ | PROT_WRITE | PROT_EXEC) != 0) {
        LOGD("nesec_bypass: mprotect failed at %p", addr);
        return;
    }
    memcpy(addr, patch, len);
    __builtin___clear_cache((char*)addr, (char*)addr + len);
    mprotect((void*)page_start, page_len, PROT_READ | PROT_EXEC);
}

static void scan_and_patch_nesec(uintptr_t base, size_t size) {
    if (nesec_patched) return;

    LOGD("nesec_bypass: scanning libnesec.so @ 0x%lx size=%zu", (unsigned long)base, size);

    const uint8_t* ptr = (const uint8_t*)base;

    // AArch64: "MOV X0, #0; RET" pattern - sahte success return
    // B0 00 80 D2 = MOV X0, #0x0
    // C0 03 5F D6 = RET
    uint8_t nop_ret_patch[] = {
        0x00, 0x00, 0x80, 0xD2,  // MOV X0, #0
        0xC0, 0x03, 0x5F, 0xD6   // RET
    };

    // "MOV X0, #1; RET" - sahte true return
    uint8_t true_ret_patch[] = {
        0x20, 0x00, 0x80, 0xD2,  // MOV X0, #1
        0xC0, 0x03, 0x5F, 0xD6   // RET
    };

    // Kritik string imzaları: "check", "verify", "root", "debug" gibi
    // Nesec çok obfuscated, bu yüzden JNI fonksiyon imzaları arıyoruz
    // "Java_" prefix arama
    int patch_count = 0;
    for (size_t i = 0; i + 256 < size; i += 4) {
        const uint8_t* p = ptr + i;

        // BL/BLR çağrılarından sonra gelen CMP/CBNZ/TBZ check'lerini bul
        // Pattern: SUB SP / STP X29 (function prolog) + sonrasında PRCTL veya kill çağrısı
        if (p[3] == 0xD1 && p[7] == 0xA9) {
            // Bu bir fonksiyon prologu, check et
            uint32_t instr = *(uint32_t*)(p + 8);
            if ((instr & 0xFC000000) == 0x94000000) {
                // BL çağrısı var, muhtemel check fonksiyonu
                // Sonuçları her zaman 0 (pass) döndüren patch
            }
        }
    }

    // ELF header'ından DT_INIT ve JNI_OnLoad bul
    Elf64_Ehdr* ehdr = (Elf64_Ehdr*)base;
    if (ehdr->e_magic[0] == 0x7F && memcmp(ehdr->e_ident, "\x7fELF", 4) == 0) {
        Elf64_Phdr* phdr = (Elf64_Phdr*)(base + ehdr->e_phoff);
        for (int i = 0; i < ehdr->e_phnum; i++) {
            if (phdr[i].p_type == PT_DYNAMIC) {
                Elf64_Dyn* dyn = (Elf64_Dyn*)(base + phdr[i].p_vaddr);
                uintptr_t symtab = 0, strtab = 0;
                size_t strsz = 0;

                while (dyn->d_tag != DT_NULL) {
                    if (dyn->d_tag == DT_SYMTAB) symtab = base + dyn->d_un.d_ptr;
                    if (dyn->d_tag == DT_STRTAB) strtab = base + dyn->d_un.d_ptr;
                    if (dyn->d_tag == DT_STRSZ) strsz = dyn->d_un.d_val;
                    if (dyn->d_tag == DT_INIT) {
                        void* init_fn = (void*)(base + dyn->d_un.d_ptr);
                        LOGD("nesec_bypass: patching DT_INIT @ %p", init_fn);
                        uint8_t ret_patch[] = {0xC0, 0x03, 0x5F, 0xD6};
                        patch_memory(init_fn, ret_patch, 4);
                        patch_count++;
                    }
                    dyn++;
                }
            }
        }
    }

    LOGD("nesec_bypass: %d patches applied", patch_count);
    nesec_patched = true;
}

extern "C" {

void* dlopen(const char* filename, int flag) {
    if (orig_dlopen == nullptr) {
        orig_dlopen = (orig_dlopen_t)dlsym(RTLD_NEXT, "dlopen");
    }

    void* handle = orig_dlopen(filename, flag);

    if (filename != nullptr && strstr(filename, "libnesec") != nullptr && handle != nullptr) {
        LOGD("nesec_bypass: libnesec.so loaded via dlopen, patching...");
        uintptr_t base = find_lib_base("libnesec.so");
        size_t size = find_lib_size(base);
        if (base && size) {
            scan_and_patch_nesec(base, size);
        }
    }

    return handle;
}

}

static void* nesec_patch_thread(void*) {
    int tries = 0;
    while (!nesec_patched && tries < 60) {
        uintptr_t base = find_lib_base("libnesec.so");
        if (base) {
            size_t size = find_lib_size(base);
            if (size) {
                usleep(50000);
                scan_and_patch_nesec(base, size);
            }
        }
        usleep(200000);
        tries++;
    }
    return nullptr;
}

void nesec_bypass_install() {
    LOGD("nesec_bypass: installing");

    pthread_t tid;
    pthread_create(&tid, nullptr, nesec_patch_thread, nullptr);
    pthread_detach(tid);
}
