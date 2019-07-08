
macro(ccf_ns add)
  if(NOT "${add}" MATCHES "^[0-9a-zA-Z-_]+$")
    message(FATAL_ERROR "Invalid NS name: \"${add}\". Can only contain numbers, letters, - and _.")
  endif()
  if(NOT DEFINED CANCELLAR_BUILD_SCOPE)
    set(CANCELLAR_BUILD_SCOPE ${add})
    set(CANCELLAR_BUILD_SCOPEDIR ${add})
  else()
    set(CANCELLAR_BUILD_SCOPE "${CANCELLAR_BUILD_SCOPE}-${add}")
    set(CANCELLAR_BUILD_SCOPEDIR "${CANCELLAR_BUILD_SCOPEDIR}/${add}")
  endif()
endmacro()

macro(_ccf_ensure_have_sources)
  list(LENGTH sources sources_count)
  if(sources_count EQUAL 0)
    message(WARNING "Target ${CANCELLAR_BUILD_SCOPE} has no sources, adding empty.${PREFERRED_CXX_EXTENSION}")
    file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/src/empty.${PREFERRED_CXX_EXTENSION}" "")
    list(APPEND sources "${CMAKE_CURRENT_SOURCE_DIR}/src/empty.${PREFERRED_CXX_EXTENSION}")
  endif()
endmacro()

function(_ccf_set_target_properties target)
  target_include_directories(${target} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
  target_include_directories(${target} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/internal_include)
  target_compile_options( ${target} PRIVATE "-Werror" "-Wextra" "-Wdocumentation" )

  if(WITH_TIDY)
    set_property(TARGET ${target} PROPERTY CXX_CLANG_TIDY "${TIDY_EXECUTABLE}")
  endif()
endfunction()

function(_ccf_ensure_directory dir)
  if(NOT IS_DIRECTORY "${dir}")
    file(MAKE_DIRECTORY "${dir}")
    message(NOTICE "Created directory ${dir}...")
  endif()
endfunction()

function(ccf_target type)

  ###### Check that the function wasn't called yet

  if(DEFINED CCF_CURRENT_TARGET)
    message(FATAL_ERROR "A target was already added at the surrent level!")
  endif()

  if(TARGET ${CANCELLAR_BUILD_SCOPE})
    message(FATAL_ERROR "Target \"${CANCELLAR_BUILD_SCOPE}\" already exists!")
  endif()

  set(CCF_CURRENT_TARGET ${CANCELLAR_BUILD_SCOPE} PARENT_SCOPE)

  ###### Create standard directories / minimal files
  
  string(TOLOWER "${type}" type_lower)

  if(NOT IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/src")
    _ccf_ensure_directory("${CMAKE_CURRENT_SOURCE_DIR}/src")
    message(NOTICE "  Creating empty source file in ${CMAKE_CURRENT_SOURCE_DIR}/src")
    file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/src/empty.${PREFERRED_CXX_EXTENSION}" "")

    if(type_lower STREQUAL "executable")
      message(NOTICE "  Creating main source file in ${CMAKE_CURRENT_SOURCE_DIR}/src")
      file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/src/main.${PREFERRED_CXX_EXTENSION}" "\n\
int main([[maybe_unused]] int argc, [[maybe_unused]] char* argv[]) {\n\
  return 0;\n\
}\n\
")
    endif()
  endif()
  _ccf_ensure_directory("${CMAKE_CURRENT_SOURCE_DIR}/doc")
  _ccf_ensure_directory("${CMAKE_CURRENT_SOURCE_DIR}/internal_include")
  _ccf_ensure_directory("${CMAKE_CURRENT_SOURCE_DIR}/include")
  _ccf_ensure_directory("${CMAKE_CURRENT_SOURCE_DIR}/tests")
  

  ###### Create targets

  file(GLOB_RECURSE sources CONFIGURE_DEPENDS "src/*")

  if(type_lower STREQUAL "executable")
    # an executable is an object library (if more than one file), and a main object, linked together
    if (NOT ";${sources};" MATCHES "main\.(cxx|cc|cpp|c);")
      message(FATAL_ERROR "Target ${CANCELLAR_BUILD_SCOPE} has no main source file!")
    endif()
    set(main_source ${sources})
    list(FILTER sources EXCLUDE REGEX "main\.(cxx|cc|cpp|c)")
    list(FILTER main_source INCLUDE REGEX "main\.(cxx|cc|cpp|c)")
    
    list(LENGTH main_source main_src_count)
    if(main_src_count GREATER 1) 
      message(FATAL_ERROR "Target ${CANCELLAR_BUILD_SCOPE} has multiple main source files!")
    endif()

    _ccf_ensure_have_sources()

    add_library(${CANCELLAR_BUILD_SCOPE}-objs OBJECT ${sources})
    add_executable(${CANCELLAR_BUILD_SCOPE} ${main_source} $<TARGET_OBJECTS:${CANCELLAR_BUILD_SCOPE}-objs>)
  elseif(type_lower STREQUAL "static_library")
    # static libraries are object libraries + static libraries
    # When linking locally, we'll link the object libraries to take advantage of LTO
  elseif(type_lower STREQUAL "shared_library")
  else()
    message(FATAL_ERROR "Unknown target type: \"${type}\"")
  endif()

  _ccf_set_target_properties(${CANCELLAR_BUILD_SCOPE})
  if(TARGET ${CANCELLAR_BUILD_SCOPE}-objs)
    _ccf_set_target_properties(${CANCELLAR_BUILD_SCOPE}-objs)
  endif()
endfunction()

MACRO( ADD_TEST_TARGET )
  ADD_TARGET( ${ARGV} )
  SET_MAIN_TARGET( "test" )
  ADD_TEST(NAME "${BUILD_SCOPE}" COMMAND "${BUILD_SCOPE}" )
  TARGET_LINK_LIBRARIES( ${BUILD_SCOPE} ${CANCELLAR_TEST_THIRD_PARTY_LIBRARIES} )
ENDMACRO()

MACRO( ADD_HAYAI_TEST_TARGET )
  IF(NOT CMAKE_BUILD_TYPE MATCHES DEBUG)
    ADD_TARGET( ${ARGV} )
    SET_MAIN_TARGET( "test" )
    ADD_TEST(NAME "${BUILD_SCOPE}" WORKING_DIRECTORY "${CANCELLAR_BUILD_BINARY_DIR}" COMMAND "$<TARGET_FILE:${BUILD_SCOPE}>" "-o" "json:${BUILD_SCOPE}.json" "-o" "console")
    TARGET_LINK_LIBRARIES( ${BUILD_SCOPE} ${CANCELLAR_TEST_THIRD_PARTY_LIBRARIES} hayai )
  ENDIF()
ENDMACRO()


MACRO( LINK_TARGET )
  SET( MYLIBS ${ARGV} )
  TARGET_LINK_LIBRARIES(${BUILD_SCOPE} ${MYLIBS})
ENDMACRO( LINK_TARGET )



MACRO( ADD_STATIC_LIB )
  FOREACH(src ${ARGV})
    LIST(APPEND ${BUILD_SCOPE}-sources "${CMAKE_CURRENT_SOURCE_DIR}/${src}")
  ENDFOREACH()
  LIST(APPEND ${BUILD_SCOPE}-all ${${BUILD_SCOPE}-sources})
  LIST(APPEND ${BUILD_SCOPE}-all ${${BUILD_SCOPE}-headers})
  ADD_LIBRARY( ${BUILD_SCOPE} STATIC ${${BUILD_SCOPE}-all})
  SET_PROPERTY( TARGET ${BUILD_SCOPE} PROPERTY POSITION_INDEPENDENT_CODE ON )

  COMMON_TARGET_PROPERTIES()
ENDMACRO( ADD_STATIC_LIB )

MACRO( ADD_SHARED_LIB )
  FOREACH(src ${ARGV})
    LIST(APPEND ${BUILD_SCOPE}-sources "${CMAKE_CURRENT_SOURCE_DIR}/${src}")
  ENDFOREACH()
  LIST(APPEND ${BUILD_SCOPE}-all ${${BUILD_SCOPE}-sources})
  LIST(APPEND ${BUILD_SCOPE}-all ${${BUILD_SCOPE}-headers})
  ADD_LIBRARY( ${BUILD_SCOPE} SHARED ${${BUILD_SCOPE}-all})
  SET_PROPERTY( TARGET ${BUILD_SCOPE} PROPERTY POSITION_INDEPENDENT_CODE ON )

  COMMON_TARGET_PROPERTIES()
ENDMACRO( ADD_SHARED_LIB )
