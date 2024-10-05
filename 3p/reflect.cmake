set(_CCF_DEP_REPOSITORY "https://github.com/qlibs/reflect.git")
set(_CCF_DEP_NAME "reflect")
set(_CCF_DEP_DEFAULT_TYPE "BRANCH")
set(_CCF_DEP_DEFAULT_VER "main")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "reflect" "." )
endmacro()
