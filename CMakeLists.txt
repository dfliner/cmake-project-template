cmake_minimum_required(VERSION 3.28.0)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(FATAL_ERROR
        "❌ Out of source tree build is required. "
        "Please clean up the source tree after this error."
    )
endif()

# the cross-compiler setup has env variables $CFLAGS and $CXXFLAGS messed up,
# adversely impacting these two variables.
set(CMAKE_C_FLAGS "" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "" CACHE STRING "" FORCE)

if(NOT DEFINED PROJECT_VERSION)
    set(PROJECT_VERSION 0.1.0)
endif()

# ideally SOVERSION would follow PROJECT_VERSION_MAJOR in the future
set(NETS_SOVERSION 1)

project(HelloWorld VERSION "${PROJECT_VERSION}" LANGUAGES C CXX)

message(STATUS "Is cross-compiling: ${CMAKE_CROSSCOMPILING}")
message(STATUS "Compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "sysroot:  ${CMAKE_SYSROOT}")

# d for debug build postfix
set(CMAKE_DEBUG_POSTFIX d)

OPTION(ENABLE_CLANG_TIDY "Enable Clang-Tidy" ON)
include(cmake/ClangTidyStaticAnalyzer.cmake)

include(cmake/NinjaMultiConfig.cmake)
include(cmake/CompilerOptions.cmake)

# d for debug build postfix
set(CMAKE_DEBUG_POSTFIX d)
# make all static libraries linkable to shared libraries by default
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# set(CMAKE_INSTALL_PREFIX "${PROJECT_BINARY_DIR}/install")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

# CPack
include(InstallRequiredSystemLibraries)
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_SOURCE_GENERATOR "TGZ")

# this module outputs the CPackConfig.cmake and CPackSourceConfig.cmake
# to archive the source tree, run: cpack --config CPackSourceConfig.cmake
include(CPack)
include(CTest)

add_subdirectory("src")
