
cmake_minimum_required(VERSION 3.15)

#### Early exit for common unsupported setups

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

#### Define options & config variables

option(WITH_TIDY "Run clang-tidy during the build, if clang is the compiler" ON)

set(CCF_DIR "${CMAKE_CURRENT_LIST_DIR}")
set(CCF_TEMPLATE_DIR "${CCF_DIR}/templates")

if(NOT DEFINED CCF_BUILD_SOURCE_DIR)
  set(CCF_BUILD_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
endif()

if(NOT DEFINED CCF_BUILD_BINARY_DIR)
  set(CCF_BUILD_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}")
endif()

if(NOT DEFINED CCF_BUILD_THIRD_PARTY_DIR)
  set( CCF_BUILD_THIRD_PARTY_DIR "${CCF_BUILD_SOURCE_DIR}/3rd-party/")
endif()

if(NOT DEFINED PREFERRED_CXX_EXTENSION)
  set(PREFERRED_CXX_EXTENSION "cxx")
endif()

#### Ensure an empty cpp source file exists
set(CCF_EMPTY "${CCF_BUILD_BINARY_DIR}/__ccf_empty.${PREFERRED_CXX_EXTENSION}")
file(WRITE "${CCF_EMPTY}" "")


#### Configure PIC/PIE flags

# TODO: push/pop stack
cmake_policy(SET CMP0083 NEW)
include(CheckPIESupported)
check_pie_supported()

#### Include main code

include(build_helpers)
include(CancellarConfig)
include(CompilerConfig)

### testing
enable_testing()

set(CCF_IGNORE "^cmake;^build;^_3p$")

### Dependencies!
if(NOT DEFINED CCF_DEPENDENCY_SUBDIR)
  set(CCF_DEPENDENCY_SUBDIR "_3p/")
endif()

set(CCF_DEPENDENCY_DIR "${CCF_BUILD_SOURCE_DIR}/${CCF_DEPENDENCY_SUBDIR}/")

include(ccf_3p)


