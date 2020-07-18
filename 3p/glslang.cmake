set(_CCF_DEP_REPOSITORY "https://github.com/KhronosGroup/glslang.git")
set(_CCF_DEP_NAME "glslang")
set(_CCF_DEP_DEFAULT_TYPE "TAG")
set(_CCF_DEP_DEFAULT_VER "8.13.3743")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)

  message("-- Building glslang ... ")
  if(NOT EXISTS ${CMAKE_BINARY_DIR}/_3p/glslang/)
    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/_3p/glslang/)
    execute_process(
        COMMAND ${CMAKE_COMMAND} 
        -G Ninja
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
        -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/_3p/glslang-inst/
        -DBUILD_SHARED_LIBS=OFF
        -DENABLE_HLSL=OFF
        -DBUILD_TESTING=OFF
        -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON
        ${CMAKE_CURRENT_SOURCE_DIR}/_3p/glslang/
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/_3p/glslang/
        OUTPUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/_3p/glslang/cmake.log
    )
  endif()
  execute_process(
    COMMAND ${CMAKE_COMMAND}  --build . --target install
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/_3p/glslang/
    OUTPUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/_3p/glslang/build.log
  )
  message("-- ... Done")

  include(${CMAKE_CURRENT_BINARY_DIR}/_3p/glslang-inst/lib/cmake/OSDependentTargets.cmake)
  include(${CMAKE_CURRENT_BINARY_DIR}/_3p/glslang-inst/lib/cmake/OGLCompilerTargets.cmake)
  include(${CMAKE_CURRENT_BINARY_DIR}/_3p/glslang-inst/lib/cmake/glslangTargets.cmake)
  include(${CMAKE_CURRENT_BINARY_DIR}/_3p/glslang-inst/lib/cmake/SPIRVTargets.cmake)

endmacro()
