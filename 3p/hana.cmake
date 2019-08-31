set(_CCF_DEP_REPOSITORY "https://github.com/boostorg/hana.git")
set(_CCF_DEP_NAME "hana")
set(_CCF_DEP_DEFAULT_TYPE "TAG")
set(_CCF_DEP_DEFAULT_VER "v1.5.0")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "hana" "include" )
endmacro()
