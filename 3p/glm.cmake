set(_CCF_DEP_REPOSITORY "https://github.com/g-truc/glm.git")
set(_CCF_DEP_NAME "glm")
set(_CCF_DEP_DEFAULT_TYPE "TAG")
set(_CCF_DEP_DEFAULT_VER "0.9.9.6")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "glm" "." )
endmacro()
