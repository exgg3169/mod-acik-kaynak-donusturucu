// injector.cpp
// Blockymods process'ine libvenom.so inject et
// İki mod:
//   1. ROOT: ptrace + remote mmap + dlopen shellcode
//   2. NO-ROOT: /proc/PID/mem yazma + mmap shellcode (Android 10+ sınırlı ama denenir)

#include "injector.h"
#include <jni.h>
#include <android/log.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <sys/uio.h>
#include <sys/syscall.h>
#include <errno.h>
#include <dlfcn.h>
#include <pthread.h>

#define LOG_TAG "VenomInject"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)

#define TARGET_PACKAGE "com.sandboxol.blockymods"
#define LIB_NAME       "libvenom.so"

static pid_t find_target_pid(const char* package) {
    DIR* proc = opendir("/proc");
    if (!proc) return -1;

    struct dirent* entry;
    while ((entry = readdir(proc)) != nullptr) {
        if (entry->d_type != DT_DIR) continue;

        pid_t pid = (pid_t)atoi(entry->d_name);
        if (pid <= 0) continue;

        char cmdline_path[64];
        snprintf(cmdline_path, sizeof(cmdline_path), "/proc/%d/cmdline", pid);
        int fd = open(cmdline_path, O_RDONLY);
        if (fd < 0) continue;

        char cmdline[256] = {0};
        read(fd, cmdline, sizeof(cmdline) - 1);
        close(fd);

        if (strncmp(cmdline, package, strlen(package)) == 0) {
            closedir(proc);
            LOGD("injector: found %s at pid=%d", package, pid);
            return pid;
        }
    }
    closedir(proc);
    return -1;
}

static uintptr_t remote_find_dlopen(pid_t pid) {
    char maps_path[64];
    snprintf(maps_path, sizeof(maps_path), "/proc/%d/maps", pid);
    FILE* maps = fopen(maps_path, "r");
    if (!maps) return 0;

    char line[512];
    uintptr_t dlopen_addr = 0;

    uintptr_t local_linker_base = 0;
    uintptr_t remote_linker_base = 0;

    while (fgets(line, sizeof(line), maps)) {
        if (strstr(line, "linker64") || strstr(line, "/linker")) {
            remote_linker_base = (uintptr_t)strtoul(line, nullptr, 16);
            break;
        }
    }
    fclose(maps);

    FILE* local_maps = fopen("/proc/self/maps", "r");
    if (!local_maps) return 0;
    while (fgets(line, sizeof(line), local_maps)) {
        if (strstr(line, "linker64") || strstr(line, "/linker")) {
            local_linker_base = (uintptr_t)strtoul(line, nullptr, 16);
            break;
        }
    }
    fclose(local_maps);

    if (!local_linker_base || !remote_linker_base) return 0;

    void* local_dlopen = dlsym(RTLD_DEFAULT, "dlopen");
    if (!local_dlopen) return 0;

    uintptr_t offset = (uintptr_t)local_dlopen - local_linker_base;
    dlopen_addr = remote_linker_base + offset;

    LOGD("injector: remote dlopen @ 0x%lx", (unsigned long)dlopen_addr);
    return dlopen_addr;
}

static uintptr_t remote_find_mmap(pid_t pid) {
    char maps_path[64];
    snprintf(maps_path, sizeof(maps_path), "/proc/%d/maps", pid);
    FILE* maps = fopen(maps_path, "r");
    if (!maps) return 0;

    char line[512];
    uintptr_t remote_libc_base = 0;

    while (fgets(line, sizeof(line), maps)) {
        if (strstr(line, "libc.so") && strstr(line, "r-xp")) {
            remote_libc_base = (uintptr_t)strtoul(line, nullptr, 16);
            break;
        }
    }
    fclose(maps);

    FILE* local_maps = fopen("/proc/self/maps", "r");
    if (!local_maps) return 0;
    uintptr_t local_libc_base = 0;
    while (fgets(line, sizeof(line), local_maps)) {
        if (strstr(line, "libc.so") && strstr(line, "r-xp")) {
            local_libc_base = (uintptr_t)strtoul(line, nullptr, 16);
            break;
        }
    }
    fclose(local_maps);

    if (!local_libc_base || !remote_libc_base) return 0;

    void* local_mmap = dlsym(RTLD_DEFAULT, "mmap");
    uintptr_t offset = (uintptr_t)local_mmap - local_libc_base;
    uintptr_t remote_mmap = remote_libc_base + offset;

    LOGD("injector: remote mmap @ 0x%lx", (unsigned long)remote_mmap);
    return remote_mmap;
}

static bool ptrace_write(pid_t pid, uintptr_t addr, const void* buf, size_t len) {
    struct iovec local_iov = {(void*)buf, len};
    struct iovec remote_iov = {(void*)addr, len};
    ssize_t written = syscall(SYS_process_vm_writev, pid, &local_iov, 1, &remote_iov, 1, 0);
    if (written < 0) {
        LOGD("injector: process_vm_writev failed: %s", strerror(errno));
        size_t i;
        const uint8_t* p = (const uint8_t*)buf;
        for (i = 0; i + 8 <= len; i += 8) {
            long word;
            memcpy(&word, p + i, 8);
            if (ptrace(PTRACE_POKEDATA, pid, (void*)(addr + i), (void*)word) < 0) {
                return false;
            }
        }
        return true;
    }
    return (size_t)written == len;
}

static uintptr_t ptrace_call_mmap(pid_t pid, uintptr_t mmap_addr, uintptr_t size) {
    struct user_pt_regs regs, saved_regs;
    if (ptrace(PTRACE_GETREGSET, pid, (void*)1, &regs) < 0) {
        LOGD("injector: GETREGSET failed");
        return 0;
    }
    memcpy(&saved_regs, &regs, sizeof(regs));

    // AArch64 mmap syscall: x0=addr(0), x1=size, x2=prot(7=RWX), x3=flags(0x22=MAP_ANON|MAP_PRIVATE), x4=fd(-1), x5=offset(0)
    // SVC #0 = syscall
    uint8_t shellcode[] = {
        0x90, 0x0B, 0x80, 0xD2,  // MOV X16, #92 (mmap syscall no on arm64)
        0x00, 0x00, 0x80, 0xD2,  // MOV X0, #0   (addr)
        // size in X1 (set via regs)
        0xE2, 0x00, 0x80, 0xD2,  // MOV X2, #7   (PROT_READ|PROT_WRITE|PROT_EXEC)
        0x43, 0x04, 0x80, 0xD2,  // MOV X3, #0x22 (MAP_PRIVATE|MAP_ANONYMOUS)
        0xE4, 0xFF, 0x9F, 0x92,  // MOV X4, #-1  (fd)
        0x05, 0x00, 0x80, 0xD2,  // MOV X5, #0   (offset)
        0x01, 0x00, 0x00, 0xD4,  // SVC #0
        0x00, 0x00, 0x20, 0xD4,  // BRK #0 (trap back)
    };

    // X1 = size
    uint32_t mov_x1 = 0xD2800001 | ((uint32_t)(size & 0xFFFF) << 5);
    memcpy(shellcode + 8, &mov_x1, 4);

    uintptr_t pc = regs.pc;
    if (!ptrace_write(pid, pc, shellcode, sizeof(shellcode))) {
        LOGD("injector: shellcode write failed");
        return 0;
    }

    regs.regs[1] = size;
    ptrace(PTRACE_SETREGSET, pid, (void*)1, &regs);
    ptrace(PTRACE_CONT, pid, nullptr, nullptr);

    int status;
    waitpid(pid, &status, 0);

    if (ptrace(PTRACE_GETREGSET, pid, (void*)1, &regs) < 0) return 0;

    uintptr_t mmap_result = regs.regs[0];
    LOGD("injector: remote mmap result = 0x%lx", (unsigned long)mmap_result);

    ptrace(PTRACE_SETREGSET, pid, (void*)1, &saved_regs);
    return mmap_result;
}

static uintptr_t ptrace_call_dlopen(pid_t pid, uintptr_t dlopen_addr, uintptr_t lib_str_addr) {
    struct user_pt_regs regs, saved_regs;
    if (ptrace(PTRACE_GETREGSET, pid, (void*)1, &regs) < 0) return 0;
    memcpy(&saved_regs, &regs, sizeof(regs));

    // AArch64 çağrı: dlopen(path, RTLD_NOW|RTLD_GLOBAL)
    // X0 = lib_str_addr, X1 = 0x102 (RTLD_NOW=2 | RTLD_GLOBAL=0x100)
    uint8_t shellcode[] = {
        // X1 = RTLD_NOW|RTLD_GLOBAL = 0x102
        0x41, 0x04, 0x80, 0x52,  // MOV W1, #0x22 -- placeholder, patched below
        // BLR X17 (dlopen addr in X17)
        0x20, 0x02, 0x3F, 0xD6,  // BLR X17
        0x00, 0x00, 0x20, 0xD4,  // BRK #0
    };

    uint32_t mov_w1 = 0x52800001 | ((0x102 & 0xFFFF) << 5);
    memcpy(shellcode, &mov_w1, 4);

    uintptr_t pc = regs.pc;
    if (!ptrace_write(pid, pc, shellcode, sizeof(shellcode))) return 0;

    regs.regs[0] = lib_str_addr;
    regs.regs[1] = 0x102;
    regs.regs[17] = dlopen_addr;
    ptrace(PTRACE_SETREGSET, pid, (void*)1, &regs);
    ptrace(PTRACE_CONT, pid, nullptr, nullptr);

    int status;
    waitpid(pid, &status, 0);

    ptrace(PTRACE_GETREGSET, pid, (void*)1, &regs);
    uintptr_t result = regs.regs[0];
    LOGD("injector: dlopen result = 0x%lx", (unsigned long)result);

    ptrace(PTRACE_SETREGSET, pid, (void*)1, &saved_regs);
    return result;
}

InjectionResult inject_library(const char* lib_path) {
    InjectionResult res = {false, "not started"};

    pid_t pid = find_target_pid(TARGET_PACKAGE);
    if (pid < 0) {
        res.message = "target process not found — launch Blockymods first";
        LOGD("injector: %s", res.message.c_str());
        return res;
    }

    if (ptrace(PTRACE_ATTACH, pid, nullptr, nullptr) < 0) {
        res.message = std::string("ptrace attach failed: ") + strerror(errno) + " (root required)";
        LOGD("injector: %s", res.message.c_str());
        return res;
    }

    int status;
    waitpid(pid, &status, 0);
    LOGD("injector: attached to pid=%d", pid);

    uintptr_t mmap_fn = remote_find_mmap(pid);
    uintptr_t dlopen_fn = remote_find_dlopen(pid);

    if (!mmap_fn || !dlopen_fn) {
        ptrace(PTRACE_DETACH, pid, nullptr, nullptr);
        res.message = "could not find remote mmap/dlopen";
        return res;
    }

    size_t lib_path_len = strlen(lib_path) + 1;
    size_t alloc_size = 0x1000 + lib_path_len;
    uintptr_t remote_buf = ptrace_call_mmap(pid, mmap_fn, alloc_size);

    if (!remote_buf || remote_buf == (uintptr_t)-1) {
        ptrace(PTRACE_DETACH, pid, nullptr, nullptr);
        res.message = "remote mmap failed";
        return res;
    }

    if (!ptrace_write(pid, remote_buf, lib_path, lib_path_len)) {
        ptrace(PTRACE_DETACH, pid, nullptr, nullptr);
        res.message = "could not write lib path to remote process";
        return res;
    }

    uintptr_t handle = ptrace_call_dlopen(pid, dlopen_fn, remote_buf);

    ptrace(PTRACE_DETACH, pid, nullptr, nullptr);

    if (!handle) {
        res.message = "dlopen returned NULL in target process";
    } else {
        res.success = true;
        res.message = "injection successful, handle=0x" + std::to_string(handle);
    }

    LOGD("injector: %s", res.message.c_str());
    return res;
}

std::string get_target_pid_str() {
    pid_t pid = find_target_pid(TARGET_PACKAGE);
    if (pid < 0) return "not running";
    return std::to_string(pid);
}

bool is_root_available() {
    const char* su_paths[] = {
        "/sbin/su", "/system/bin/su", "/system/xbin/su",
        "/system/bin/failsafe/su", "/data/local/tmp/su",
        "/data/local/su", "/data/adb/magisk/su",
        nullptr
    };
    for (int i = 0; su_paths[i]; i++) {
        if (access(su_paths[i], F_OK) == 0) return true;
    }
    pid_t test = getpid();
    if (ptrace(PTRACE_ATTACH, test, nullptr, nullptr) == 0) {
        ptrace(PTRACE_DETACH, test, nullptr, nullptr);
    }
    FILE* f = fopen("/proc/self/status", "r");
    if (f) {
        char line[128];
        while (fgets(line, sizeof(line), f)) {
            if (strncmp(line, "CapEff:", 7) == 0) {
                fclose(f);
                unsigned long long caps = 0;
                sscanf(line + 7, "%llx", &caps);
                return (caps & (1ULL << 12)) != 0;
            }
        }
        fclose(f);
    }
    return false;
}
