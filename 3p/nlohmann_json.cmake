set(_CCF_DEP_REPOSITORY "https://github.com/nlohmann/json.git")
set(_CCF_DEP_NAME "nlohmann_json")
set(_CCF_DEP_DEFAULT_TYPE "TAG")
set(_CCF_DEP_DEFAULT_VER "v3.7.3")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "nlohmann_json" "single_include" )
endmacro()
