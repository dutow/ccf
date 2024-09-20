# Manages a shallow clone as a submodule for dependencies, and ensures unchanged state on the specified commit
# Use DISABLE_CHECKS when local checks are neccessary.
# Usage:
# ccf_3p(dep_name <COMMIT|TAG> <reference> [DISABLE_CHECKS])

find_package(Git REQUIRED)

macro(_ccf_dep_git_fetch)
  if(ref_type MATCHES "TAG")
    execute_process(COMMAND ${GIT_EXECUTABLE} fetch --depth 1 origin "refs/tags/${ver}:refs/tags/${ver}"
      WORKING_DIRECTORY "${CCF_BUILD_SOURCE_DIR}/${dep_directory}"
      OUTPUT_QUIET
      ERROR_VARIABLE DEP_ERROR
      RESULT_VARIABLE DEP_RESULT
    )
  endif()
  if(ref_type MATCHES "COMMIT")
    execute_process(COMMAND ${GIT_EXECUTABLE} fetch --depth 1 origin "${ver}"
      WORKING_DIRECTORY "${CCF_BUILD_SOURCE_DIR}/${dep_directory}"
      OUTPUT_QUIET
      ERROR_VARIABLE DEP_ERROR
      RESULT_VARIABLE DEP_RESULT
    )
  endif()
  if(ref_type MATCHES "BRANCH")
    execute_process(COMMAND ${GIT_EXECUTABLE} fetch origin master
      WORKING_DIRECTORY "${CCF_BUILD_SOURCE_DIR}/${dep_directory}"
      OUTPUT_QUIET
      ERROR_VARIABLE DEP_ERROR
      RESULT_VARIABLE DEP_RESULT
    )
  endif()
  if(NOT "${DEP_RESULT}" EQUAL 0)
    message(FATAL_ERROR "GIT fetch failed for dep ${_CCF_DEP_NAME}: ${DEP_ERROR}")
  endif()
endmacro()

macro(_ccf_dep_git_status)
  execute_process(COMMAND ${GIT_EXECUTABLE} submodule status ${dep_directory} 
    WORKING_DIRECTORY "${CCF_BUILD_SOURCE_DIR}"
    RESULT_VARIABLE DEP_RESULT
    OUTPUT_VARIABLE DEP_OUTPUT
    ERROR_VARIABLE DEP_ERROR
  )
endmacro()

macro(_ccf_dep_git_init)
  execute_process(COMMAND ${GIT_EXECUTABLE} init
    WORKING_DIRECTORY "${CCF_BUILD_SOURCE_DIR}/${dep_directory}"
    OUTPUT_QUIET
    ERROR_VARIABLE DEP_ERROR
    RESULT_VARIABLE DEP_RESULT
  )
  if(NOT "${DEP_RESULT}" EQUAL 0)
    message(FATAL_ERROR "GIT init failed for dep ${_CCF_DEP_NAME}: ${DEP_ERROR}")
  endif()
  execute_process(COMMAND ${GIT_EXECUTABLE} remote rm origin
    WORKING_DIRECTORY "${CCF_BUILD_SOURCE_DIR}/${dep_directory}"
    OUTPUT_QUIET
    ERROR_VARIABLE DEP_ERROR
    RESULT_VARIABLE DEP_RESULT
  )
  execute_process(COMMAND ${GIT_EXECUTABLE} remote add origin ${_CCF_DEP_REPOSITORY}
    WORKING_DIRECTORY "${CCF_BUILD_SOURCE_DIR}/${dep_directory}"
    OUTPUT_QUIET
    ERROR_VARIABLE DEP_ERROR
    RESULT_VARIABLE DEP_RESULT
  )
  if(NOT "${DEP_RESULT}" EQUAL 0)
    message(FATAL_ERROR "GIT remote add origin failed for dep ${_CCF_DEP_NAME}: ${DEP_ERROR}")
  endif()
  execute_process(COMMAND ${GIT_EXECUTABLE} submodule add ${_CCF_DEP_REPOSITORY} ${dep_directory}
    WORKING_DIRECTORY "${CCF_BUILD_SOURCE_DIR}"
    OUTPUT_QUIET
    ERROR_VARIABLE DEP_ERROR
    RESULT_VARIABLE DEP_RESULT
  )
  if(NOT "${DEP_RESULT}" EQUAL 0)
    message(FATAL_ERROR "GIT submodule add failed for dep ${_CCF_DEP_NAME}: ${DEP_ERROR}")
  endif()
endmacro()

macro(_ccf_dep_git_update)
  execute_process(COMMAND ${GIT_EXECUTABLE}  submodule update --init --depth 1 "${dep_directory}"
    WORKING_DIRECTORY "${CCF_BUILD_SOURCE_DIR}"
    RESULT_VARIABLE DEP_RESULT
    ERROR_VARIABLE DEP_ERROR
  )
  if(NOT "${DEP_RESULT}" EQUAL 0)
    message(FATAL_ERROR "GIT update failed for dep ${_CCF_DEP_NAME}: ${DEP_ERROR}")
  endif()
endmacro()

macro(_ccf_dep_git_clean)
  execute_process(COMMAND ${GIT_EXECUTABLE} clean -xdf .
    WORKING_DIRECTORY "${CCF_BUILD_SOURCE_DIR}/${dep_directory}"
    OUTPUT_QUIET
    ERROR_VARIABLE DEP_ERROR
    RESULT_VARIABLE DEP_RESULT
  )
  if(NOT "${DEP_RESULT}" EQUAL 0)
    message(FATAL_ERROR "GIT clean failed for dep ${_CCF_DEP_NAME}: ${DEP_ERROR}")
  endif()
endmacro()

macro(_ccf_dep_git_checkout_fetchhead)
  execute_process(COMMAND ${GIT_EXECUTABLE} checkout FETCH_HEAD
    WORKING_DIRECTORY "${CCF_BUILD_SOURCE_DIR}/${dep_directory}"
    OUTPUT_QUIET
    ERROR_VARIABLE DEP_ERROR
    RESULT_VARIABLE DEP_RESULT
  )
  if(NOT "${DEP_RESULT}" EQUAL 0)
    message(FATAL_ERROR "GIT checkout failed for dep ${_CCF_DEP_NAME}: ${DEP_ERROR}")
  endif()
endmacro()

macro(ccf_3p_lib_header_only target)
  if(NOT EXISTS "${CCF_BUILD_SOURCE_DIR}/${dep_directory}/")
    message(FATAL_ERROR "Third party directory doesn't exists: ${CCF_BUILD_SOURCE_DIR}/${dep_directory}/")
  endif()

  add_library(${target} INTERFACE)

  set(_argn_list "${ARGN}")
  foreach(arg IN LISTS _argn_list)
    if(NOT EXISTS "${CCF_BUILD_SOURCE_DIR}/${dep_directory}/${arg}")
      message(FATAL_ERROR "Third party subdirectory doesn't exists: ${CCF_BUILD_SOURCE_DIR}/${dep_directory}/${arg}")
    endif()
    target_include_directories(${target} INTERFACE "${CCF_BUILD_SOURCE_DIR}/${dep_directory}/${arg}")
  endforeach()
endmacro()

# syntax: name <TAG/COMMIT/BRANCH> <ref>
function(ccf_3p a_dep a_ref_type)
  string(TOLOWER "${a_dep}" dep)
  string(TOUPPER "${a_ref_type}" ref_type)

  if(DEFINED "CCF_DEPENDS_${dep}")
    # TODO: version checks!
    return()
  endif()

  set(_allowed_values "TAG;COMMIT;BRANCH;DEFAULT")
  if (NOT "${ref_type}" IN_LIST _allowed_values)
    message(FATAL_ERROR "Unknown reference type for dependency ${dep}: ${ref_type}")
  endif()

  macro(_ccf_3p_target_callback)
  endmacro()

  # load the settings we need
  include("3p/${dep}")
  set(dep_directory "${CCF_DEPENDENCY_SUBDIR}/${_CCF_DEP_NAME}")
  set("CCF_DEPENDS_${dep}" ON PARENT_SCOPE)

  _ccf_3p_target_callback()

endfunction()
