set(_CCF_DEP_REPOSITORY "https://github.com/apolukhin/magic_get.git")
set(_CCF_DEP_NAME "magic_get")
set(_CCF_DEP_DEFAULT_TYPE "BRANCH")
set(_CCF_DEP_DEFAULT_VER "abb467c0e22a83bf75a46a9e6610370fabfc39af")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "magic_get" "include" )
endmacro()
