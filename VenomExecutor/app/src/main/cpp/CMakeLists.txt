cmake_minimum_required(VERSION 3.22.1)
project("venom")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)

include(FetchContent)
FetchContent_Declare(
    lua
    URL https://www.lua.org/ftp/lua-5.4.6.tar.gz
    URL_HASH SHA256=7d5ea1b9cb6aa0b59ca3dde1c6adcb57ef83a1ba8e5432c0ecd06bf439b3ad88
)
FetchContent_MakeAvailable(lua)

set(LUA_SRC
    ${lua_SOURCE_DIR}/src/lapi.c
    ${lua_SOURCE_DIR}/src/lauxlib.c
    ${lua_SOURCE_DIR}/src/lbaselib.c
    ${lua_SOURCE_DIR}/src/lcode.c
    ${lua_SOURCE_DIR}/src/lcorolib.c
    ${lua_SOURCE_DIR}/src/lctype.c
    ${lua_SOURCE_DIR}/src/ldblib.c
    ${lua_SOURCE_DIR}/src/ldebug.c
    ${lua_SOURCE_DIR}/src/ldo.c
    ${lua_SOURCE_DIR}/src/ldump.c
    ${lua_SOURCE_DIR}/src/lfunc.c
    ${lua_SOURCE_DIR}/src/lgc.c
    ${lua_SOURCE_DIR}/src/linit.c
    ${lua_SOURCE_DIR}/src/liolib.c
    ${lua_SOURCE_DIR}/src/llex.c
    ${lua_SOURCE_DIR}/src/lmathlib.c
    ${lua_SOURCE_DIR}/src/lmem.c
    ${lua_SOURCE_DIR}/src/loadlib.c
    ${lua_SOURCE_DIR}/src/lobject.c
    ${lua_SOURCE_DIR}/src/lopcodes.c
    ${lua_SOURCE_DIR}/src/loslib.c
    ${lua_SOURCE_DIR}/src/lparser.c
    ${lua_SOURCE_DIR}/src/lstate.c
    ${lua_SOURCE_DIR}/src/lstring.c
    ${lua_SOURCE_DIR}/src/lstrlib.c
    ${lua_SOURCE_DIR}/src/ltable.c
    ${lua_SOURCE_DIR}/src/ltablib.c
    ${lua_SOURCE_DIR}/src/ltm.c
    ${lua_SOURCE_DIR}/src/lundump.c
    ${lua_SOURCE_DIR}/src/lutf8lib.c
    ${lua_SOURCE_DIR}/src/lvm.c
    ${lua_SOURCE_DIR}/src/lzio.c
)

add_library(venom SHARED
    jni_bridge.cpp
    bypass/root_bypass.cpp
    bypass/anti_debug.cpp
    bypass/nesec_bypass.cpp
    bypass/pglarmor_bypass.cpp
    bypass/injector.cpp
)

target_include_directories(venom PRIVATE
    ${lua_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_sources(venom PRIVATE ${LUA_SRC})

target_compile_options(venom PRIVATE
    -O2
    -fvisibility=hidden
    -fstack-protector-strong
    -Wno-unused-variable
    -Wno-unused-function
)

target_compile_definitions(venom PRIVATE
    LUA_USE_LINUX
    NDEBUG
)

find_library(log-lib log)
find_library(dl-lib dl)

target_link_libraries(venom
    ${log-lib}
    ${dl-lib}
)

# ---------------------------------------------------------------
# libvenom_payload.so  — Blockymods process'ine inject edilecek SO
# Minimal, sadece JNI_OnLoad + Lua resolve + script execution
# ---------------------------------------------------------------
add_library(venom_payload SHARED
    payload_stub.cpp
)

target_compile_options(venom_payload PRIVATE
    -O2
    -fvisibility=hidden
    -fstack-protector-strong
    -Wno-unused-variable
    -Wno-unused-function
)

target_compile_definitions(venom_payload PRIVATE
    NDEBUG
)

target_link_libraries(venom_payload
    ${log-lib}
    ${dl-lib}
)
