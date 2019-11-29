# 
# Provides a basic config file for configuration management (e.g. platform, architechture, etc.)
# 
# Provided macro definitions:
# (definitions are also provided as lowercase constepxr functions in the CCF::compiler_config namespace, without 
# the CCF_ prefix)
#
# CCF_PLATFORM (string) - name of the active OS platform
# CCF_PLATFORM_WINDOWS (0/1) - 1 if building for Windows
# CCF_PLATFORM_LINUX (0/1) - 1 if building for Linux
#
# CCF_ARCH(string) - name of the active computer architechture
# CCF_ARCH_X86 (0/1) - 1 if building for x86, 32 or 64 bit
# CCF_ARCH_X86_32 (0/1) - 1 if building for 32 bit x86
# CCF_ARCH_X86_64 (0/1) - 1 if building for 64 bit x86
# 

MACRO( C_MARKER_IF TARGET_VARIABLE MARKER_VARIABLE)
  IF( ${MARKER_VARIABLE} )
    SET( ${TARGET_VARIABLE} 1 )
  ELSE()
    SET( ${TARGET_VARIABLE} 0 )
  ENDIF()
ENDMACRO()

SET( CCF_PLATFORM "${CMAKE_SYSTEM_NAME}" )
C_MARKER_IF( "CCF_PLATFORM_WINDOWS" "WIN32" )
C_MARKER_IF( "CCF_PLATFORM_LINUX" "UNIX" )

# TODO: Support fr non-X86 architechture!
SET( CCF_ARCH "x86" )
SET( CCF_ARCH_X86 1 )
IF( "${CMAKE_SIZEOF_VOID_P}" EQUAL "8" )
  SET( CCF_ARCH "x86_64" )
  SET( CCF_ARCH_X86_32 0 )
  SET( CCF_ARCH_X86_64 1 )
  SET( CCF_ARCH_32 0 )
  SET( CCF_ARCH_64 1 )
ELSE()
  SET( CCF_ARCH "x86_32" )
  SET( CCF_ARCH_X86_32 1 )
  SET( CCF_ARCH_X86_64 0 )
  SET( CCF_ARCH_32 1 )
  SET( CCF_ARCH_64 0 )
ENDIF()

CONFIGURE_FILE("${CMAKE_CURRENT_LIST_DIR}/ccf_config.hxx" "compiler-config/ccf_config.hxx")
INCLUDE_DIRECTORIES( "${CMAKE_CURRENT_BINARY_DIR}/compiler-config" )

