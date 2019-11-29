set(_CCF_DEP_REPOSITORY "https://github.com/eranpeer/FakeIt.git")
set(_CCF_DEP_NAME "fakeit")
set(_CCF_DEP_DEFAULT_TYPE "TAG")
set(_CCF_DEP_DEFAULT_VER "2.0.5")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "fakeit" "single_header/catch" )
endmacro()
