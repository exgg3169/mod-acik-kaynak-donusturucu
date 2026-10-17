// jni_bridge.cpp
// Ana JNI köprüsü — Lua engine + bypass başlatma + injection

#include <jni.h>
#include <string>
#include <android/log.h>
#include <dlfcn.h>
#include <pthread.h>

#include "bypass/root_bypass.h"
#include "bypass/anti_debug.h"
#include "bypass/nesec_bypass.h"
#include "bypass/pglarmor_bypass.h"
#include "bypass/injector.h"

extern "C" {
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
}

#define LOG_TAG "VenomJNI"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)

static lua_State* L = nullptr;

static void register_venom_api(lua_State* state) {
    lua_register(state, "log", [](lua_State* ls) -> int {
        const char* msg = luaL_checkstring(ls, 1);
        __android_log_print(ANDROID_LOG_INFO, "VenomLua", "%s", msg);
        return 0;
    });

    lua_register(state, "sleep", [](lua_State* ls) -> int {
        int ms = (int)luaL_checknumber(ls, 1);
        usleep(ms * 1000);
        return 0;
    });

    lua_register(state, "get_pid", [](lua_State* ls) -> int {
        std::string pid_str = get_target_pid_str();
        lua_pushstring(ls, pid_str.c_str());
        return 1;
    });
}

JNIEXPORT void JNICALL
Java_com_venom_executor_LuaEngine_init(JNIEnv* env, jobject thiz) {
    if (L == nullptr) {
        L = luaL_newstate();
        if (L) {
            luaL_openlibs(L);
            register_venom_api(L);
            LOGD("Lua state initialized");
        }
    }

    root_bypass_install_hooks();
    anti_debug_install();
    nesec_bypass_install();
    pglarmor_bypass_install();

    LOGD("All bypasses installed");
}

JNIEXPORT jstring JNICALL
Java_com_venom_executor_LuaEngine_execute(JNIEnv* env, jobject thiz, jstring code) {
    if (L == nullptr) {
        return env->NewStringUTF("Lua engine not initialized");
    }

    const char* script = env->GetStringUTFChars(code, nullptr);
    int top_before = lua_gettop(L);
    int status = luaL_dostring(L, script);
    env->ReleaseStringUTFChars(code, script);

    if (status != LUA_OK) {
        const char* err = lua_tostring(L, -1);
        lua_pop(L, 1);
        std::string msg = "Lua error: ";
        msg += (err ? err : "unknown");
        return env->NewStringUTF(msg.c_str());
    }

    int top_after = lua_gettop(L);
    if (top_after > top_before) {
        size_t len;
        const char* result = luaL_tolstring(L, -1, &len);
        std::string ret(result ? result : "nil", len);
        lua_pop(L, 2);
        return env->NewStringUTF(ret.c_str());
    }

    return env->NewStringUTF("OK");
}

JNIEXPORT jstring JNICALL
Java_com_venom_executor_LuaEngine_injectIntoGame(JNIEnv* env, jobject thiz, jstring libPath) {
    const char* path = env->GetStringUTFChars(libPath, nullptr);
    InjectionResult result = inject_library(path);
    env->ReleaseStringUTFChars(libPath, path);

    std::string msg = result.success ? "[OK] " : "[FAIL] ";
    msg += result.message;
    return env->NewStringUTF(msg.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_venom_executor_LuaEngine_getTargetPid(JNIEnv* env, jobject thiz) {
    std::string pid = get_target_pid_str();
    return env->NewStringUTF(pid.c_str());
}

JNIEXPORT void JNICALL
Java_com_venom_executor_LuaEngine_resetState(JNIEnv* env, jobject thiz) {
    if (L != nullptr) {
        lua_close(L);
        L = nullptr;
    }
    L = luaL_newstate();
    if (L) {
        luaL_openlibs(L);
        register_venom_api(L);
        LOGD("Lua state reset");
    }
}

JNIEXPORT jboolean JNICALL
Java_com_venom_executor_LuaEngine_isRootAvailable(JNIEnv* env, jobject thiz) {
    return (jboolean) is_root_available();
}
