
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
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fmsc-version=1900") # compatible with VS2015
	IF( CANCELLAR_ARCH_64 ) 
      SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m64")
	ELSEIF( CANCELLAR_ARCH_32 )
      SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32")	
	ELSE()
	  MESSAGE(FATAL_ERROR "Unknown architechture for clang-cl")
	ENDIF()
	
  ENDIF()
  IF( CLANG_CL )
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Xclang -Wno-c++1z-extensions") # allow experimental C++17
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unknown-pragmas") # msvc pragmas in boost
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-microsoft-unqualified-friend") # msvc specific code in boost
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-microsoft-enum-value") # msvc specific code in boost
  IF( CMAKE_CXX_COMPILER_VERSION VERSION_GREATER 3.9 )
  	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-expansion-to-defined") # TODO: too much easylogging warnings with clang4
  ENDIF ()
	
	# TODO: fix warnings and add Werror
  ENDIF()
ELSE()
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall") # enable every warning
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unknown-pragmas") # e.g. pragma region / endregion
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-c++1z-extensions") # allow experimental C++17
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror") # treat warnings as errors
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pedantic") # be more standard compliant
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-vla-extension") # required for SFML. TODO: different warnings for vendors!
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated-declarations") # required for SFML. TODO: different warnings for vendors!
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unused-variable") # required for SFML. TODO: different warnings for vendors!
  IF( CMAKE_CXX_COMPILER_VERSION VERSION_GREATER 3.9 )
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-expansion-to-defined") # TODO: too much easylogging warnings with clang4
  ENDIF()

  SET ( CMAKE_CXX_STANDARD 14 )  

ENDIF()

