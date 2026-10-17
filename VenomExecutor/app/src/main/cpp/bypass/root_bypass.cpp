// root_bypass.cpp
// Hedef: com.sandboxol.blockymods
// Bypass: su/magisk/supersu binary arama, Build.TAGS, RootBeer/SafetyNet detection

#include "root_bypass.h"
#include <jni.h>
#include <string>
#include <android/log.h>
#include <dlfcn.h>
#include <sys/stat.h>
#include <unistd.h>
#include <cstring>
#include <fcntl.h>

#define LOG_TAG "VenomRoot"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)

static const char* ROOT_PATHS[] = {
    "/sbin/su",
    "/system/bin/su",
    "/system/xbin/su",
    "/system/su",
    "/system/app/SuperSU/SuperSU.apk",
    "/system/app/Superuser.apk",
    "/data/local/tmp/su",
    "/data/local/su",
    "/system/xbin/daemonsu",
    "/system/etc/.installed_su_daemon",
    "/system/bin/.ext/.su",
    "/system/usr/we-need-root/su-backup",
    "/system/xbin/mu",
    "/sbin/.magisk",
    "/data/adb/magisk",
    "/data/adb/magisk.db",
    "/data/adb/modules",
    "/cache/.disable_magisk",
    "/dev/magisk",
    nullptr
};

typedef int (*orig_access_t)(const char* pathname, int mode);
typedef int (*orig_stat_t)(const char* pathname, struct stat* statbuf);
typedef int (*orig_open_t)(const char* pathname, int flags, ...);

static orig_access_t orig_access = nullptr;
static orig_stat_t orig_stat = nullptr;
static orig_open_t orig_open = nullptr;

static bool is_root_path(const char* path) {
    if (path == nullptr) return false;
    for (int i = 0; ROOT_PATHS[i] != nullptr; i++) {
        if (strcmp(path, ROOT_PATHS[i]) == 0) return true;
    }
    if (strstr(path, "magisk") != nullptr) return true;
    if (strstr(path, "supersu") != nullptr) return true;
    if (strstr(path, "superuser") != nullptr) return true;
    if (strstr(path, "/su") != nullptr && strstr(path, "bin/su") != nullptr) return true;
    return false;
}

extern "C" {

int access(const char* pathname, int mode) {
    if (is_root_path(pathname)) {
        LOGD("root_bypass: access blocked for %s", pathname);
        errno = ENOENT;
        return -1;
    }
    if (orig_access == nullptr) {
        orig_access = (orig_access_t)dlsym(RTLD_NEXT, "access");
    }
    return orig_access(pathname, mode);
}

int stat(const char* pathname, struct stat* statbuf) {
    if (is_root_path(pathname)) {
        LOGD("root_bypass: stat blocked for %s", pathname);
        errno = ENOENT;
        return -1;
    }
    if (orig_stat == nullptr) {
        orig_stat = (orig_stat_t)dlsym(RTLD_NEXT, "stat");
    }
    return orig_stat(pathname, statbuf);
}

int open(const char* pathname, int flags, ...) {
    if (is_root_path(pathname)) {
        LOGD("root_bypass: open blocked for %s", pathname);
        errno = ENOENT;
        return -1;
    }
    if (orig_open == nullptr) {
        orig_open = (orig_open_t)dlsym(RTLD_NEXT, "open");
    }
    mode_t mode = 0;
    if (flags & O_CREAT) {
        va_list args;
        va_start(args, flags);
        mode = va_arg(args, mode_t);
        va_end(args);
    }
    return orig_open(pathname, flags, mode);
}

}

void root_bypass_install_hooks() {
    LOGD("root_bypass: hooks installed");
}
