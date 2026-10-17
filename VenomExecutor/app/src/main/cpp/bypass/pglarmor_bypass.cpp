// pglarmor_bypass.cpp
// Hedef: libpglarmor.so (ByteDance PGL Crypt Utils)
// Export bulundu: Java_com_bytedance_sdk_component_pglcrypt_PglCryptUtils_bc
// Strateji:
//   1. Bu JNI fonksiyonunu hook'la, her zaman başarı kodu döndür
//   2. libpglarmor.so'nun DT_INIT'ini NOP'la
//   3. PGLArmor'un cihaz/bütünlük doğrulama sonuçlarını sahte yap

#include "pglarmor_bypass.h"
#include <jni.h>
#include <android/log.h>
#include <dlfcn.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stdio.h>
#include <elf.h>
#include <pthread.h>

#define LOG_TAG "VenomPGL"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)

static uintptr_t find_lib_base(const char* libname) {
    FILE* maps = fopen("/proc/self/maps", "r");
    if (!maps) return 0;
    char line[512];
    uintptr_t base = 0;
    while (fgets(line, sizeof(line), maps)) {
        if (strstr(line, libname) && strstr(line, "r--p")) {
            base = (uintptr_t)strtoul(line, nullptr, 16);
            break;
        }
    }
    if (!base) {
        rewind(maps);
        while (fgets(line, sizeof(line), maps)) {
            if (strstr(line, libname)) {
                base = (uintptr_t)strtoul(line, nullptr, 16);
                break;
            }
        }
    }
    fclose(maps);
    return base;
}

static void patch_memory(void* addr, const uint8_t* patch, size_t len) {
    uintptr_t page_start = ((uintptr_t)addr) & ~((uintptr_t)(getpagesize() - 1));
    size_t page_len = (((uintptr_t)addr + len - page_start) + getpagesize() - 1) & ~((size_t)(getpagesize() - 1));
    mprotect((void*)page_start, page_len, PROT_READ | PROT_WRITE | PROT_EXEC);
    memcpy(addr, patch, len);
    __builtin___clear_cache((char*)addr, (char*)addr + len);
    mprotect((void*)page_start, page_len, PROT_READ | PROT_EXEC);
}

static uintptr_t find_symbol_in_lib(uintptr_t base, const char* sym_name) {
    Elf64_Ehdr* ehdr = (Elf64_Ehdr*)base;
    if (memcmp(ehdr->e_ident, "\x7fELF", 4) != 0) return 0;

    Elf64_Phdr* phdr = (Elf64_Phdr*)(base + ehdr->e_phoff);
    uintptr_t symtab = 0, strtab = 0;
    size_t sym_count = 0;

    for (int i = 0; i < ehdr->e_phnum; i++) {
        if (phdr[i].p_type == PT_DYNAMIC) {
            Elf64_Dyn* dyn = (Elf64_Dyn*)(base + phdr[i].p_vaddr);
            while (dyn->d_tag != DT_NULL) {
                if (dyn->d_tag == DT_SYMTAB) symtab = base + dyn->d_un.d_ptr;
                if (dyn->d_tag == DT_STRTAB) strtab = base + dyn->d_un.d_ptr;
                if (dyn->d_tag == DT_SYMENT) sym_count = dyn->d_un.d_val;
                dyn++;
            }
        }
    }

    if (!symtab || !strtab) return 0;

    Elf64_Sym* sym = (Elf64_Sym*)symtab;
    for (int i = 0; ; i++) {
        if (sym[i].st_name == 0 && i > 0) break;
        if (sym[i].st_value == 0) { sym++; continue; }
        const char* name = (const char*)(strtab + sym[i].st_name);
        if (strcmp(name, sym_name) == 0) {
            return base + sym[i].st_value;
        }
        if (i > 10000) break;
    }
    return 0;
}

static void patch_pglarmor(uintptr_t base) {
    LOGD("pglarmor_bypass: patching @ 0x%lx", (unsigned long)base);

    // Java_com_bytedance_sdk_component_pglcrypt_PglCryptUtils_bc
    // Bu fonksiyon muhtemelen bir şifreleme/doğrulama fonksiyonu
    // Return value'yu 0 (success) olarak patch et
    uintptr_t bc_fn = find_symbol_in_lib(base, "Java_com_bytedance_sdk_component_pglcrypt_PglCryptUtils_bc");
    if (bc_fn) {
        LOGD("pglarmor_bypass: found bc @ 0x%lx, patching", (unsigned long)bc_fn);
        // AArch64: MOV X0, #0; RET
        uint8_t patch[] = {
            0x00, 0x00, 0x80, 0xD2,  // MOV X0, #0
            0xC0, 0x03, 0x5F, 0xD6   // RET
        };
        patch_memory((void*)bc_fn, patch, sizeof(patch));
        LOGD("pglarmor_bypass: bc patched");
    } else {
        LOGD("pglarmor_bypass: bc not found via ELF, trying offset scan");
        // dlsym ile dene
        void* handle = dlopen("libpglarmor.so", RTLD_NOLOAD);
        if (handle) {
            void* fn = dlsym(handle, "Java_com_bytedance_sdk_component_pglcrypt_PglCryptUtils_bc");
            if (fn) {
                uint8_t patch[] = {
                    0x00, 0x00, 0x80, 0xD2,
                    0xC0, 0x03, 0x5F, 0xD6
                };
                patch_memory(fn, patch, sizeof(patch));
                LOGD("pglarmor_bypass: bc patched via dlsym");
            }
        }
    }

    // DT_INIT NOP
    Elf64_Ehdr* ehdr = (Elf64_Ehdr*)base;
    if (memcmp(ehdr->e_ident, "\x7fELF", 4) == 0) {
        Elf64_Phdr* phdr = (Elf64_Phdr*)(base + ehdr->e_phoff);
        for (int i = 0; i < ehdr->e_phnum; i++) {
            if (phdr[i].p_type == PT_DYNAMIC) {
                Elf64_Dyn* dyn = (Elf64_Dyn*)(base + phdr[i].p_vaddr);
                while (dyn->d_tag != DT_NULL) {
                    if (dyn->d_tag == DT_FINI) {
                        void* fini = (void*)(base + dyn->d_un.d_ptr);
                        uint8_t ret_only[] = {0xC0, 0x03, 0x5F, 0xD6};
                        patch_memory(fini, ret_only, 4);
                        LOGD("pglarmor_bypass: DT_FINI patched");
                    }
                    dyn++;
                }
            }
        }
    }
}

static bool pglarmor_patched = false;

static void* pglarmor_patch_thread(void*) {
    int tries = 0;
    while (!pglarmor_patched && tries < 60) {
        uintptr_t base = find_lib_base("libpglarmor.so");
        if (base) {
            patch_pglarmor(base);
            pglarmor_patched = true;
        }
        usleep(200000);
        tries++;
    }
    return nullptr;
}

void pglarmor_bypass_install() {
    LOGD("pglarmor_bypass: installing");
    pthread_t tid;
    pthread_create(&tid, nullptr, pglarmor_patch_thread, nullptr);
    pthread_detach(tid);
}
