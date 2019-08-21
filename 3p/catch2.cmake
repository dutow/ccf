set(_CCF_DEP_REPOSITORY "https://github.com/catchorg/Catch2.git")
set(_CCF_DEP_NAME "catch2")
set(_CCF_DEP_DEFAULT_TYPE "TAG")
set(_CCF_DEP_DEFAULT_VER "v2.9.2")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "catch2" "single_include/catch2" )
endmacro()
