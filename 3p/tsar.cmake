set(_CCF_DEP_REPOSITORY "https://github.com/dutow/tsar.git")
set(_CCF_DEP_NAME "tsar")
set(_CCF_DEP_DEFAULT_TYPE "BRANCH")
set(_CCF_DEP_DEFAULT_VER "4a3fa849b9947f6a739223345b70f23dc49caa19")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "tsar" "include" )
endmacro()
