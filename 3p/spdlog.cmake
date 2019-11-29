set(_CCF_DEP_REPOSITORY "https://github.com/gabime/spdlog.git")
set(_CCF_DEP_NAME "spdlog")
set(_CCF_DEP_DEFAULT_TYPE "TAG")
set(_CCF_DEP_DEFAULT_VER "v1.4.2")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "spdlog" "include" )
endmacro()
