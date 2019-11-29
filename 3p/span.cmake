set(_CCF_DEP_REPOSITORY "https://github.com/tcbrindle/span.git")
set(_CCF_DEP_NAME "span")
set(_CCF_DEP_DEFAULT_TYPE "BRANCH")
set(_CCF_DEP_DEFAULT_VER "9d7559aabdebf569cab3480a7ea2a87948c0ae47")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "span" "include" )
endmacro()
