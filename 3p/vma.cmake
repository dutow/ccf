set(_CCF_DEP_REPOSITORY "https://github.com/malte-v/VulkanMemoryAllocator-Hpp.git")
set(_CCF_DEP_NAME "vma")
set(_CCF_DEP_DEFAULT_TYPE "BRANCH")
set(_CCF_DEP_DEFAULT_VER "master")
#set(_CCF_DEP_IGNORE_CHANGES ON)

macro(_ccf_3p_target_callback)
  ccf_3p_lib_header_only( "vma" "include" "VulkanMemoryAllocator/include" )
endmacro()
