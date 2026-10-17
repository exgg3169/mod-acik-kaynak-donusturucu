// payload_stub.cpp
// Bu SO Blockymods process'ine inject edilir.
// JNI_OnLoad içinde Blockymods'un Lua state'ini bulup custom-4.lua'yı çalıştırır.
//
// Blockymods Lua kütüphanesi: libKingKM.so veya libblockman.so altında
// Arama sırası: dlsym(RTLD_DEFAULT) -> /proc/self/maps scan -> libKingKM.so dlopen

#include <jni.h>
#include <android/log.h>
#include <dlfcn.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/mman.h>
#include <stdint.h>

#define LOG_TAG "VenomPayload"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

// Lua 5.1/5.2/5.3/5.4 state opaque struct — sadece pointer kullanıyoruz
typedef struct lua_State lua_State;

// Blockymods Lua function pointer types
typedef lua_State* (*lua_newstate_fn)(void* allocf, void* ud);
typedef void       (*lua_close_fn)(lua_State* L);
typedef int        (*luaL_loadstring_fn)(lua_State* L, const char* s);
typedef int        (*lua_pcall_fn)(lua_State* L, int nargs, int nresults, int errfunc);
typedef void       (*lua_pop_fn)(lua_State* L, int n);
typedef int        (*lua_gettop_fn)(lua_State* L);
typedef const char*(*lua_tostring_fn)(lua_State* L, int index, size_t* len);
typedef void       (*luaL_openlibs_fn)(lua_State* L);
typedef int        (*luaL_loadbuffer_fn)(lua_State* L, const char* buff, size_t sz, const char* name);

static lua_newstate_fn   fn_lua_newstate   = nullptr;
static luaL_openlibs_fn  fn_luaL_openlibs  = nullptr;
static luaL_loadbuffer_fn fn_luaL_loadbuffer = nullptr;
static lua_pcall_fn      fn_lua_pcall      = nullptr;
static lua_pop_fn        fn_lua_pop        = nullptr;
static lua_tostring_fn   fn_lua_tostring   = nullptr;
static lua_gettop_fn     fn_lua_gettop     = nullptr;

// Script kaynağı: inject eden taraftan geçirilen path
static char g_script_path[512] = {0};
static char g_script_content[1024 * 512] = {0};  // 512KB buffer
static size_t g_script_size = 0;

static bool try_load_lua_fns(void* lib) {
    if (!lib) return false;
    fn_lua_newstate    = (lua_newstate_fn)  dlsym(lib, "lua_newstate");
    fn_luaL_openlibs   = (luaL_openlibs_fn) dlsym(lib, "luaL_openlibs");
    fn_luaL_loadbuffer = (luaL_loadbuffer_fn)dlsym(lib, "luaL_loadbuffer");
    fn_lua_pcall       = (lua_pcall_fn)     dlsym(lib, "lua_pcall");
    fn_lua_pop         = (lua_pop_fn)       dlsym(lib, "lua_settop");
    fn_lua_tostring    = (lua_tostring_fn)  dlsym(lib, "lua_tolstring");
    fn_lua_gettop      = (lua_gettop_fn)    dlsym(lib, "lua_gettop");
    return (fn_lua_newstate && fn_luaL_loadbuffer && fn_lua_pcall);
}

static void* resolve_lua_lib() {
    // 1. RTLD_DEFAULT — eğer Blockymods Lua global'e export ettiyse
    if (try_load_lua_fns(RTLD_DEFAULT)) {
        LOGD("payload: lua fns found in RTLD_DEFAULT");
        return RTLD_DEFAULT;
    }

    // 2. Bilinen lib isimlerini dene
    const char* candidates[] = {
        "libKingKM.so",
        "libblockman.so",
        "liblua.so",
        "liblua5.4.so",
        "liblua5.3.so",
        "liblua5.1.so",
        "liblua54.so",
        nullptr
    };
    for (int i = 0; candidates[i]; i++) {
        void* h = dlopen(candidates[i], RTLD_NOW | RTLD_NOLOAD);
        if (!h) h = dlopen(candidates[i], RTLD_NOW | RTLD_GLOBAL);
        if (h && try_load_lua_fns(h)) {
            LOGD("payload: lua fns found in %s", candidates[i]);
            return h;
        }
    }

    // 3. /proc/self/maps üzerinden Lua kütüphanesi tara
    FILE* maps = fopen("/proc/self/maps", "r");
    if (maps) {
        char line[512];
        while (fgets(line, sizeof(line), maps)) {
            if ((strstr(line, "lua") || strstr(line, "KingKM") || strstr(line, "blockman"))
                && strstr(line, ".so")) {
                // lib adını çıkar
                char* path_start = strchr(line, '/');
                if (path_start) {
                    path_start[strcspn(path_start, "\n")] = 0;
                    void* h = dlopen(path_start, RTLD_NOW | RTLD_NOLOAD);
                    if (!h) h = dlopen(path_start, RTLD_NOW);
                    if (h && try_load_lua_fns(h)) {
                        LOGD("payload: lua fns found in %s", path_start);
                        fclose(maps);
                        return h;
                    }
                }
            }
        }
        fclose(maps);
    }

    LOGE("payload: could not resolve Lua library");
    return nullptr;
}

static bool read_script(const char* path) {
    FILE* f = fopen(path, "rb");
    if (!f) {
        LOGE("payload: cannot open script: %s", path);
        return false;
    }
    g_script_size = fread(g_script_content, 1, sizeof(g_script_content) - 1, f);
    fclose(f);
    g_script_content[g_script_size] = 0;
    LOGD("payload: script loaded %zu bytes from %s", g_script_size, path);
    return g_script_size > 0;
}

static void* payload_thread(void*) {
    // Blockymods tamamen açılana kadar bekle
    usleep(2000000);  // 2 saniye

    if (g_script_size == 0) {
        if (!read_script(g_script_path)) {
            LOGE("payload: script load failed, aborting");
            return nullptr;
        }
    }

    void* lua_lib = resolve_lua_lib();
    if (!lua_lib) {
        LOGE("payload: no lua lib, aborting");
        return nullptr;
    }

    lua_State* L = fn_lua_newstate(nullptr, nullptr);
    if (!L) {
        LOGE("payload: lua_newstate failed");
        return nullptr;
    }

    if (fn_luaL_openlibs) fn_luaL_openlibs(L);

    LOGD("payload: executing custom-4.lua (%zu bytes)", g_script_size);

    int status = fn_luaL_loadbuffer(L, g_script_content, g_script_size, "@custom-4.lua");
    if (status != 0) {
        size_t len;
        const char* err = fn_lua_tostring ? fn_lua_tostring(L, -1, &len) : "?";
        LOGE("payload: load error: %s", err ? err : "unknown");
        return nullptr;
    }

    status = fn_lua_pcall(L, 0, -1, 0);
    if (status != 0) {
        size_t len;
        const char* err = fn_lua_tostring ? fn_lua_tostring(L, -1, &len) : "?";
        LOGE("payload: runtime error: %s", err ? err : "unknown");
    } else {
        LOGD("payload: custom-4.lua executed successfully");
    }

    return nullptr;
}

JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* reserved) {
    LOGD("payload: JNI_OnLoad - libvenom_payload.so loaded into Blockymods");

    // Script path'i hazırla
    // Önce /data/local/tmp dene, sonra /sdcard
    const char* paths[] = {
        "/data/local/tmp/custom-4.lua",
        "/sdcard/custom-4.lua",
        "/sdcard/Android/data/com.sandboxol.blockymods/files/custom-4.lua",
        nullptr
    };
    for (int i = 0; paths[i]; i++) {
        FILE* f = fopen(paths[i], "r");
        if (f) {
            fclose(f);
            strncpy(g_script_path, paths[i], sizeof(g_script_path) - 1);
            LOGD("payload: script path set to %s", g_script_path);
            break;
        }
    }

    if (g_script_path[0] == 0) {
        LOGE("payload: no script file found, will retry in thread");
        strncpy(g_script_path, "/data/local/tmp/custom-4.lua", sizeof(g_script_path) - 1);
    }

    pthread_t tid;
    pthread_create(&tid, nullptr, payload_thread, nullptr);
    pthread_detach(tid);

    return JNI_VERSION_1_6;
}
