# 
# Provides a basic config file for configuration management (e.g. platform, architechture, etc.)
# 
# Provided macro definitions:
# (definitions are also provided as lowercase constepxr functions in the cancellar::compiler_config namespace, without 
# the CANCELLAR_ prefix)
#
# CANCELLAR_PLATFORM (string) - name of the active OS platform
# CANCELLAR_PLATFORM_WINDOWS (0/1) - 1 if building for Windows
# CANCELLAR_PLATFORM_LINUX (0/1) - 1 if building for Linux
#
# CANCELLAR_ARCH(string) - name of the active computer architechture
# CANCELLAR_ARCH_X86 (0/1) - 1 if building for x86, 32 or 64 bit
# CANCELLAR_ARCH_X86_32 (0/1) - 1 if building for 32 bit x86
# CANCELLAR_ARCH_X86_64 (0/1) - 1 if building for 64 bit x86
# 

MACRO( C_MARKER_IF TARGET_VARIABLE MARKER_VARIABLE)
  IF( ${MARKER_VARIABLE} )
    SET( ${TARGET_VARIABLE} 1 )
  ELSE()
    SET( ${TARGET_VARIABLE} 0 )
  ENDIF()
ENDMACRO()

SET( CANCELLAR_PLATFORM "${CMAKE_SYSTEM_NAME}" )
C_MARKER_IF( "CANCELLAR_PLATFORM_WINDOWS" "WIN32" )
C_MARKER_IF( "CANCELLAR_PLATFORM_LINUX" "UNIX" )

# TODO: Support fr non-X86 architechture!
SET( CANCELLAR_ARCH "x86" )
SET( CANCELLAR_ARCH_X86 1 )
IF( "${CMAKE_SIZEOF_VOID_P}" EQUAL "8" )
  SET( CANCELLAR_ARCH "x86_64" )
  SET( CANCELLAR_ARCH_X86_32 0 )
  SET( CANCELLAR_ARCH_X86_64 1 )
  SET( CANCELLAR_ARCH_32 0 )
  SET( CANCELLAR_ARCH_64 1 )
ELSE()
  SET( CANCELLAR_ARCH "x86_32" )
  SET( CANCELLAR_ARCH_X86_32 1 )
  SET( CANCELLAR_ARCH_X86_64 0 )
  SET( CANCELLAR_ARCH_32 1 )
  SET( CANCELLAR_ARCH_64 0 )
ENDIF()

CONFIGURE_FILE("${CMAKE_CURRENT_LIST_DIR}/cancellar_config.hxx" "compile-config/cancellar_config.hxx")
INCLUDE_DIRECTORIES( "${CMAKE_CURRENT_BINARY_DIR}/compile-config" )

