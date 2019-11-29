set(_CCF_DEP_REPOSITORY "https://github.com/Neargye/magic_enum.git")
set(_CCF_DEP_NAME "magic_enum")
set(_CCF_DEP_DEFAULT_TYPE "TAG")
set(_CCF_DEP_DEFAULT_VER "v0.6.3")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "magic_enum" "include" )
endmacro()
