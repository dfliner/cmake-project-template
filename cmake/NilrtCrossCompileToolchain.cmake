cmake_minimum_required(VERSION 3.28.0)

if (NOT DEFINED ENV{SDKROOT} AND NOT DEFINED ENV{SDKTARGETSYSROOT})
    message(FATAL_ERROR
        "❌ SDKROOT not defined. The cross-compilation environment wasn't correctly set."
    )
endif()

message(STATUS "Using NI LinuxRT cross-compilers")

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(toolchain_path $ENV{SDKROOT}/sysroots)
string(REPLACE "\\"  "/" toolchain_path ${toolchain_path})

set(CMAKE_SYSROOT ${toolchain_path}/core2-64-nilrt-linux)

set(CMAKE_C_COMPILER ${toolchain_path}/x86_64-nilrtsdk-linux/usr/bin/x86_64-nilrt-linux/x86_64-nilrt-linux-gcc)
set(CMAKE_CXX_COMPILER ${toolchain_path}/x86_64-nilrtsdk-linux/usr/bin/x86_64-nilrt-linux/x86_64-nilrt-linux-g++)

set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES
    ${toolchain_path}/core2-64-nilrt-linux/usr/include/c++/11.3.0
    ${toolchain_path}/core2-64-nilrt-linux/usr/include/c++/11.3.0/x86_64-nilrt-linux
)

# Uncomment if compiler cannot find the standard C headers
# include_directories(SYSTEM
#     ${toolchain_path}/core2-64-nilrt-linux/usr/inlcude
#     ${toolchain_path}/core2-64-nilrt-linux/usr/local/inlcude
# )

# Common - this overwrites the environment variables
set(NILRT_COMPILER_EXTRA_FLAGS "-m64 -march=core2 -mtune=core2 -msse3 -mfpmath=sse")
set(CMAKE_C_FLAGS "$ENV{CFLAGS} ${NILRT_COMPILER_EXTRA_FLAGS}")
set(CMAKE_CXX_FLAGS "$ENV{CXXFLAGS} ${NILRT_COMPILER_EXTRA_FLAGS}")

set(CMAKE_STAGING_PREFIX ${CMAKE_SYSROOT}/usr/local)
set(CMAKE_INSTALL_PREFIX /usr/local)

# How CMAKE_FIND_ROOT_PATH is used for each type of search
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
