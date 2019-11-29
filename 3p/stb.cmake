set(_CCF_DEP_REPOSITORY "https://github.com/nothings/stb.git")
set(_CCF_DEP_NAME "stb")
set(_CCF_DEP_DEFAULT_TYPE "BRANCH")
set(_CCF_DEP_DEFAULT_VER "f67165c2bb2af3060ecae7d20d6f731173485ad0")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "stb" "." )
endmacro()
