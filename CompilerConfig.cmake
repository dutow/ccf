
# Adds additional compler flags
IF ( CMAKE_CXX_COMPILER_ID MATCHES "Clang" AND NOT WIN32)
  #SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++" )
  #SET( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lc++ -lc++abi" )
ENDIF()

SET(CMAKE_CXX_STANDARD 20)
