
# Adds additional compler flags

IF( MSVC )
  IF( CMAKE_VS_PLATFORM_TOOLSET MATCHES "LLVM-vs2014" )
    MESSAGE(NOTICE "Using clang-cl with tooclhain")
    SET (CLANG_CL ON)
	  SET (CLANG_CL_TOOLCHAIN ON)
  ELSEIF( CMAKE_CXX_COMPILER MATCHES ".*clang-cl.*" )
    MESSAGE(NOTICE "Using clang-cl without tooclhain")
	  SET (CLANG_CL ON)
	  SET (CLANG_CL_TOOLCHAIN OFF)
  ELSE()
    MESSAGE(NOTICE "Using MSVC cl")
    SET (CLANG_CL OFF)
  	SET (CLANG_CL_TOOLCHAIN OFF)
  ENDIF()
  IF( CLANG_CL AND NOT CLANG_CL_TOOLCHAIN )
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fmsc-version=1910") # compatible with VS2017
    IF( CANCELLAR_ARCH_64 )
      SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m64")
    ELSEIF( CANCELLAR_ARCH_32 )
      SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32")
    ELSE()
	    MESSAGE(FATAL_ERROR "Unknown architechture for clang-cl")
    ENDIF()
  ENDIF()
ELSE()
  # The C++ standard library has to be set globally to ensure that dependencies are built with the same
  IF ( CMAKE_CXX_COMPILER_ID MATCHES "Clang" )
    SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++" )
    SET( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lc++ -lc++abi" )
  ENDIF()

  # Default to C++14 - this avoids some auto_ptr issues in vendors
  SET(CMAKE_CXX_STANDARD 14)
ENDIF()

