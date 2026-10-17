#pragma once
#include <string>

struct InjectionResult {
    bool success;
    std::string message;
};

InjectionResult inject_library(const char* lib_path);
std::string get_target_pid_str();
bool is_root_available();
