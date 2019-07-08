
cmake_minimum_required(VERSION 3.15)

if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
  message(FATAL_ERROR "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there. You may need to remove CMakeCache.txt.")
endif()

if(NOT CMAKE_GENERATOR STREQUAL "Ninja")
  message(FATAL_ERROR "CCF only supports the Ninja generator. Please re-run CMake with -G Ninja. You may need to remove CMakeCache.txt.")
endif()

if(NOT CMAKE_CXX_COMPILER_ID STREQUAL "Clang"
   OR NOT CMAKE_C_COMPILER_ID STREQUAL "Clang"
   OR NOT "x${CMAKE_CXX_COMPILER_FRONTEND_VARIANT}" STREQUAL "xGNU")
  message(FATAL_ERROR "CCF only supports the Clang compiler, using the GNU-style command line (not clang-cl). Please re-run CMake with the C and C++ compiler set to clang/clang++. You may need to remove CMakeCache.txt.")
endif()

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(CheckIPOSupported)
check_ipo_supported()
set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)

option(WITH_TIDY "Run clang-tidy during the build, if clang is the compiler" ON)
option(WITH_STATIC_LIBS "Generate static libraries? Most of the time those aren't needed with LTO" OFF)

if(NOT DEFINED CANCELLAR_BUILD_SOURCE_DIR)
  set(CANCELLAR_BUILD_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
endif()

if(NOT DEFINED CANCELLAR_BUILD_BINARY_DIR)
  set(CANCELLAR_BUILD_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}")
endif()

if(NOT DEFINED CANCELLAR_BUILD_THIRD_PARTY_DIR)
  set( CANCELLAR_BUILD_THIRD_PARTY_DIR "${CANCELLAR_BUILD_SOURCE_DIR}/3rd-party/")
endif()

if(NOT DEFINED PREFERRED_CXX_EXTENSION)
  set(PREFERRED_CXX_EXTENSION "cxx")
endif()

include(build_helpers)
include(CancellarConfig)
include(CompilerConfig)

include( third-parties/third-party-helper )


