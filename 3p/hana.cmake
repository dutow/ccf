set(_CCF_DEP_REPOSITORY "https://github.com/boostorg/hana.git")
set(_CCF_DEP_NAME "hana")
set(_CCF_DEP_DEFAULT_TYPE "BRANCH")
set(_CCF_DEP_DEFAULT_VER "07b42492765f7384e053c4761f4d0eda32b75834")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "hana" "include" )
endmacro()
