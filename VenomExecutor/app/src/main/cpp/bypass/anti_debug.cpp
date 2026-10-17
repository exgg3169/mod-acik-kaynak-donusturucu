// anti_debug.cpp
// Bypass: ptrace self-attach, TracerPid okuma, inotify debugger detection,
//         SIGKILL/SIGSTOP handler'ları, Nesec/PGLArmor anti-debug metodları

#include "anti_debug.h"
#include <jni.h>
#include <android/log.h>
#include <dlfcn.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <string.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/prctl.h>

#define LOG_TAG "VenomAntiDbg"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)

typedef long (*orig_ptrace_t)(int request, pid_t pid, void* addr, void* data);
typedef int (*orig_read_t)(int fd, void* buf, size_t count);

static orig_ptrace_t orig_ptrace = nullptr;
static orig_read_t orig_read = nullptr;

static bool ends_with(const char* str, const char* suffix) {
    size_t sl = strlen(str), suffl = strlen(suffix);
    if (suffl > sl) return false;
    return strcmp(str + sl - suffl, suffix) == 0;
}

static int get_fd_path(int fd, char* out, size_t out_len) {
    char link[64];
    snprintf(link, sizeof(link), "/proc/self/fd/%d", fd);
    ssize_t r = readlink(link, out, out_len - 1);
    if (r < 0) return -1;
    out[r] = 0;
    return 0;
}

extern "C" {

long ptrace(int request, pid_t pid, void* addr, void* data) {
    if (request == PTRACE_TRACEME) {
        LOGD("anti_debug: PTRACE_TRACEME blocked");
        return 0;
    }
    if (orig_ptrace == nullptr) {
        orig_ptrace = (orig_ptrace_t)dlsym(RTLD_NEXT, "ptrace");
    }
    return orig_ptrace(request, pid, addr, data);
}

ssize_t read(int fd, void* buf, size_t count) {
    if (orig_read == nullptr) {
        orig_read = (orig_read_t)dlsym(RTLD_NEXT, "read");
    }

    char path[256] = {0};
    get_fd_path(fd, path, sizeof(path));

    if (ends_with(path, "/status") && strstr(path, "/proc/self") != nullptr) {
        ssize_t result = orig_read(fd, buf, count);
        if (result > 0) {
            char* content = (char*)buf;
            char* tracer = strstr(content, "TracerPid:");
            if (tracer != nullptr) {
                char* newline = strchr(tracer, '\n');
                char* colon = strchr(tracer, ':');
                if (colon != nullptr && newline != nullptr) {
                    colon++;
                    while (*colon == ' ' || *colon == '\t') colon++;
                    if (*colon != '0') {
                        LOGD("anti_debug: TracerPid patched to 0");
                        *colon = '0';
                        colon++;
                        while (colon < newline) {
                            *colon = ' ';
                            colon++;
                        }
                    }
                }
            }
        }
        return result;
    }

    if (ends_with(path, "/wchan") && strstr(path, "/proc/") != nullptr) {
        ssize_t result = orig_read(fd, buf, count);
        if (result > 0) {
            const char* ptrace_stop = "ptrace_stop";
            if (strstr((char*)buf, ptrace_stop) != nullptr) {
                memcpy(buf, "sys_epoll_wait", 14);
                ((char*)buf)[14] = 0;
                result = 14;
                LOGD("anti_debug: wchan patched");
            }
        }
        return result;
    }

    return orig_read(fd, buf, count);
}

}

static void* anti_debug_thread(void*) {
    prctl(PR_SET_DUMPABLE, 0);

    while (true) {
        int fd = open("/proc/self/status", O_RDONLY);
        if (fd >= 0) {
            char buf[4096];
            ssize_t n = ::read(fd, buf, sizeof(buf) - 1);
            close(fd);
            if (n > 0) {
                buf[n] = 0;
                char* tracer = strstr(buf, "TracerPid:");
                if (tracer) {
                    int pid = atoi(tracer + 10);
                    if (pid != 0) {
                        LOGD("anti_debug: debugger detected (pid=%d), killing", pid);
                        kill(pid, SIGKILL);
                    }
                }
            }
        }
        usleep(500000);
    }
    return nullptr;
}

void anti_debug_install() {
    LOGD("anti_debug: installing hooks");
    ptrace(PTRACE_TRACEME, 0, nullptr, nullptr);
    prctl(PR_SET_DUMPABLE, 0);

    pthread_t tid;
    pthread_create(&tid, nullptr, anti_debug_thread, nullptr);
    pthread_detach(tid);

    LOGD("anti_debug: installed");
}
