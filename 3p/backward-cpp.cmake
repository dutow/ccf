set(_CCF_DEP_REPOSITORY "https://github.com/dutow/backward-cpp.git")
set(_CCF_DEP_NAME "backward-cpp")
set(_CCF_DEP_DEFAULT_TYPE "BRANCH")
set(_CCF_DEP_DEFAULT_VER "7cbf4c25e9d925b9b5da815901468b4bf6adfcce")

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "backward-cpp" "." )
endmacro()
