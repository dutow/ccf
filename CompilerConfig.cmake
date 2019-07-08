
# Adds additional compler flags
IF ( CMAKE_CXX_COMPILER_ID MATCHES "Clang" AND NOT WIN32)
  SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++" )
  SET( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lc++ -lc++abi" )
ENDIF()

if ( WIN32 )
  add_definitions(-D_SILENCE_CXX17_RESULT_OF_DEPRECATION_WARNING ) # fmt bug
endif ()

SET(CMAKE_CXX_STANDARD 17)
