add_library(project_compiler_options INTERFACE)

set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,AppleClang,Clang,GNU>")
set(gcc_warning_flags "-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused")

# use c++17 standard
target_compile_features(project_compiler_options
    INTERFACE
        c_std_17
        cxx_std_17
)

# set(CMAKE_C_EXTENSIONS OFF)
# set(CMAKE_CXX_EXTENSIONS OFF)

# specify compiler warning flags when building this project through
# BUILD_INTERFACE generator expression
target_compile_options(project_compiler_options
    INTERFACE
        "$<${gcc_like_cxx}:$<BUILD_INTERFACE:${gcc_warning_flags}>>"
        # "$<$<COMPILE_LANGUAGE:C>:-std=c17>"
        # "$<$<COMPILE_LANGUAGE:CXX>:-std=c++17>"
)

target_compile_definitions(project_compiler_options
    INTERFACE
        $<$<CONFIG:Debug>:DEBUG>
        $<$<CONFIG:Release>:NDEBUG>
)
