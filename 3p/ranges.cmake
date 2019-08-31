set(_CCF_DEP_REPOSITORY "https://github.com/ericniebler/range-v3.git")
set(_CCF_DEP_NAME "ranges")
set(_CCF_DEP_DEFAULT_TYPE "TAG")
set(_CCF_DEP_DEFAULT_VER "0.9.0")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "ranges" "include" )
endmacro()
