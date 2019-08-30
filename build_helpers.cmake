
function(ccf_ns)
  if("${ARGC}" GREATER 0)
    set(add "${ARGV0}")
  else()
    get_filename_component(add ${CMAKE_CURRENT_LIST_DIR} NAME)
  endif()
  if(NOT "${add}" MATCHES "^[0-9a-zA-Z-_]+$")
    message(FATAL_ERROR "Invalid NS name: \"${add}\". Can only contain numbers, letters, - and _.")
  endif()
  if(NOT DEFINED CCF_BUILD_SCOPE)
    set(CCF_BUILD_SCOPE ${add} PARENT_SCOPE)
    set(CCF_BUILD_SCOPEDIR ${add} PARENT_SCOPE)
    set(CCF_BUILD_SCOPEVAR ${add} PARENT_SCOPE)
  elseif("${add}" STREQUAL "tests")
    set(CCF_BUILD_SCOPE "test-${CCF_BUILD_SCOPE}" PARENT_SCOPE)
    set(CCF_BUILD_SCOPEDIR "${CCF_BUILD_SCOPEDIR}/${add}" PARENT_SCOPE)
    set(CCF_BUILD_SCOPEVAR "${CCF_BUILD_SCOPEDIR}_${add}" PARENT_SCOPE)
    set(CCF_TEST_MODE ON PARENT_SCOPE)
  else()
    set(CCF_BUILD_SCOPE "${CCF_BUILD_SCOPE}-${add}" PARENT_SCOPE)
    set(CCF_BUILD_SCOPEDIR "${CCF_BUILD_SCOPEDIR}/${add}" PARENT_SCOPE)
    set(CCF_BUILD_SCOPEVAR "${CCF_BUILD_SCOPEDIR}_${add}" PARENT_SCOPE)
  endif()

  set(CCF_IGNORE "^cmake;^build;^_3p$;^[.]git$" PARENT_SCOPE)
endfunction()

macro(ccf_ignore)
  list(APPEND "CCF_IGNORE_${CCF_BUILD_SCOPEVAR}" ${ARGN})
endmacro()

function(_ccf_set_target_properties target)
  target_include_directories(${target} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
  target_include_directories(${target} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/internal_include)
  target_compile_options( ${target} PRIVATE "-Werror" "-Wextra" "-Wdocumentation" )

  set_property(TARGET ${target} PROPERTY POSITION_INDEPENDENT_CODE ON)
  set_property(TARGET ${target} PROPERTY INTERPROCEDURAL_OPTIMIZATION ON)

  get_target_property(target_type ${target} TYPE)

  if(target_type STREQUAL "SHARED_LIBRARY" AND WIN32)
    set_property(TARGET ${target} PROPERTY WINDOWS_EXPORT_ALL_SYMBOLS ON)
    # TODO: fix cmake bindexplib to support bitcode objects
    #set_property(TARGET ${target} PROPERTY INTERPROCEDURAL_OPTIMIZATION OFF)
  endif()

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

  if(TARGET ${CCF_BUILD_SCOPE})
    message(FATAL_ERROR "Target \"${CCF_BUILD_SCOPE}\" already exists!")
  endif()

  set(CCF_CURRENT_TARGET ${CCF_BUILD_SCOPE} PARENT_SCOPE)

  ###### Create standard directories / minimal files
  
  string(TOLOWER "${type}" type_lower)

  if(NOT IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/src")
    _ccf_ensure_directory("${CMAKE_CURRENT_SOURCE_DIR}/src")

    if(type_lower STREQUAL "executable")
      message(NOTICE "  Creating main source file in ${CMAKE_CURRENT_SOURCE_DIR}/src")

      if(CCF_TEST_MODE)
        file(COPY "${CCF_TEMPLATE_DIR}/test/main.cxx" 
             DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/src/")
      else()
        file(COPY "${CCF_TEMPLATE_DIR}/executable/main.cxx" 
             DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/src/")
      endif()
    endif()
  endif()
  _ccf_ensure_directory("${CMAKE_CURRENT_SOURCE_DIR}/doc")
  _ccf_ensure_directory("${CMAKE_CURRENT_SOURCE_DIR}/internal_include")
  _ccf_ensure_directory("${CMAKE_CURRENT_SOURCE_DIR}/include")
  if(NOT CCF_TEST_MODE)
    _ccf_ensure_directory("${CMAKE_CURRENT_SOURCE_DIR}/tests")
  endif()

  ###### Create & configure targets

  file(GLOB_RECURSE sources CONFIGURE_DEPENDS "src/*")

  if(type_lower STREQUAL "executable")
    # an executable is an object library (if more than one file), and a main object, linked together
    if (NOT ";${sources};" MATCHES "main\.(cxx|cc|cpp|c);")
      message(FATAL_ERROR "Target ${CCF_BUILD_SCOPE} has no main source file!")
    endif()
    set(main_source ${sources})
    list(FILTER sources EXCLUDE REGEX "main\.(cxx|cc|cpp|c)")
    list(FILTER main_source INCLUDE REGEX "main\.(cxx|cc|cpp|c)")
    
    list(LENGTH main_source main_src_count)
    if(main_src_count GREATER 1) 
      message(FATAL_ERROR "Target ${CCF_BUILD_SCOPE} has multiple main source files!")
    endif()

    set(TEST_DEP ${CCF_BUILD_SCOPE}-objs)
    add_library(${CCF_BUILD_SCOPE}-objs OBJECT ${sources} "${CCF_EMPTY}")
    add_executable(${CCF_BUILD_SCOPE} ${main_source} $<TARGET_OBJECTS:${CCF_BUILD_SCOPE}-objs>)
    target_link_libraries(${CCF_BUILD_SCOPE} ${CCF_BUILD_SCOPE}-objs)
  elseif(type_lower STREQUAL "static_library")
    add_library(${CCF_BUILD_SCOPE} STATIC ${sources} "${CCF_EMPTY}")
    set(TEST_DEP ${CCF_BUILD_SCOPE})
  elseif(type_lower STREQUAL "shared_library")
    add_library(${CCF_BUILD_SCOPE} SHARED ${sources} "${CCF_EMPTY}")
    set(TEST_DEP ${CCF_BUILD_SCOPE})
  else()
    message(FATAL_ERROR "Unknown target type: \"${type}\"")
  endif()

  _ccf_set_target_properties(${CCF_BUILD_SCOPE})
  if(TARGET ${CCF_BUILD_SCOPE}-objs)
    _ccf_set_target_properties(${CCF_BUILD_SCOPE}-objs)
  endif()

  ###### Add test targets
  if(NOT EXISTS "tests/CMakeLists.txt")
    file(GLOB tests_content CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/tests/*")
    foreach(entry ${tests_content})
      if(IS_DIRECTORY "${entry}")
        if(NOT EXISTS "${entry}/CMakeLists.txt")
          message(NOTICE "  Creating CCF CMakeLists.txt in ${entry}")
          file(COPY "${CCF_TEMPLATE_DIR}/test/CMakeLists.txt" 
               DESTINATION "${entry}/" )
        endif()
        add_subdirectory("${entry}")
      endif()
    endforeach()
  endif()
endfunction()

function(ccf_depends)
  foreach(dep ${ARGV})
    if(NOT TARGET ${dep})
      ccf_3p(${dep} DEFAULT)
    endif()

    if(TARGET ${dep})
      if(TARGET "${CCF_BUILD_SCOPE}-objs")
        target_link_libraries("${CCF_BUILD_SCOPE}-objs" ${dep})
      elseif(TARGET "${CCF_BUILD_SCOPE}")
        target_link_libraries("${CCF_BUILD_SCOPE}" ${dep})
      else()
        message(FATAL_ERROR "The target of the current scope doesn't exists yet: ${CCF_BUILD_SCOPE}")
      endif()
    else()
      message(FATAL_ERROR "Dependency not found for target ${CCF_BUILD_SCOPE}: ${dep}")
    endif()
  endforeach()
endfunction()

function(ccf_add_all a_scope_default)
  string(TOUPPER "${a_scope_default}" scope_default)
  set(scope_options "NAMESPACE;TARGET")
  if(NOT "${scope_default}" IN_LIST scope_options)
    message(FATAL_ERROR "Unknown option for ccf_add_all. Allowed: NAMESPACE, TARGET. Got: ${scope_default}")
  endif()

  file(GLOB content CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*")
  foreach(entry ${content})
    get_filename_component(entry_n "${entry}" NAME)
    
    set(_excluded OFF)
    foreach(limit IN LISTS CCF_IGNORE)
      if("${limit}" MATCHES "${entry_n}")
        set(_excluded ON)
      endif()
    endforeach()
    if(IS_DIRECTORY "${entry}" AND NOT _excluded)
      if(NOT EXISTS "${entry}/CMakeLists.txt")
        message(NOTICE "  Creating CCF CMakeLists.txt in ${entry}")

        if("${scope_default}" STREQUAL "NAMESPACE")
          file(COPY "${CCF_TEMPLATE_DIR}/namespace/CMakeLists.txt" 
               DESTINATION "${entry}/" )
        endif()
        if("${scope_default}" STREQUAL "TARGET")
          file(COPY "${CCF_TEMPLATE_DIR}/executable/CMakeLists.txt" 
               DESTINATION "${entry}/" )
        endif()
      endif()
      add_subdirectory("${entry}")
    endif()
  endforeach()
endfunction()

function(ccf_test)
  if(${ARGC} GREATER 0)
    set(_test_name ${ARG0})
    set(_args ${ARGN})
    list(REMOVE_AT _args 0)
  else()
    set(_test_name ${CCF_BUILD_SCOPE})
    set(_args "")
  endif()
  add_test(NAME ${_test_name} COMMAND $<TARGET_FILE:${CCF_BUILD_SCOPE}> ${_args})
endfunction()
