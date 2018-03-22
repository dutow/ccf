# Finds X11 includes and libraries

INCLUDE_GUARD()

IF( CANCELLAR_PLATFORM_LINUX )
  FIND_PACKAGE( X11 REQUIRED )
  LIST( APPEND CANCELLAR_THIRD_PARTY_INCLUDES "${X11_INCLUDE_DIR}" )
  LIST( APPEND CANCELLAR_THIRD_PARTY_LIBRARIES "${X11_LIBRARIES}" )
ENDIF()

