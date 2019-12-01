set(_CCF_DEP_REPOSITORY "https://github.com/dutow/glbinding.git")
set(_CCF_DEP_NAME "glbinding")
set(_CCF_DEP_DEFAULT_TYPE "TAG")
set(_CCF_DEP_DEFAULT_VER "clangfix2")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)

  message("-- Building glbinding ... ")
  if(NOT EXISTS ${CMAKE_BINARY_DIR}/_3p/glbinding/)
    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/_3p/glbinding/)
    execute_process(
        COMMAND ${CMAKE_COMMAND} 
        -G Ninja
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
        -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON
        ${CMAKE_CURRENT_SOURCE_DIR}/_3p/glbinding/
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/_3p/glbinding/
        OUTPUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/_3p/glbinding/cmake.log
    )
  endif()
  execute_process(
    COMMAND ${CMAKE_COMMAND}  --build .
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/_3p/glbinding/
    OUTPUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/_3p/glbinding/build.log
  )
  message("-- ... Done")

  include(${CMAKE_CURRENT_BINARY_DIR}/_3p/glbinding/cmake/KHRplatform/KHRplatform-export.cmake)
  include(${CMAKE_CURRENT_BINARY_DIR}/_3p/glbinding/cmake/glbinding/glbinding-export.cmake)
  include(${CMAKE_CURRENT_BINARY_DIR}/_3p/glbinding/cmake/glbinding-aux/glbinding-aux-export.cmake)

endmacro()
