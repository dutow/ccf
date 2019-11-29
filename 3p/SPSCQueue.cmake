set(_CCF_DEP_REPOSITORY "https://github.com/rigtorp/SPSCQueue.git")
set(_CCF_DEP_NAME "SPSCQueue")
set(_CCF_DEP_DEFAULT_TYPE "BRANCH")
set(_CCF_DEP_DEFAULT_VER "22191c03391e86ca50d012e9f031b13118153134")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "SPSCQueue" "include" )
endmacro()
