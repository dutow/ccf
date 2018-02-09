# Adds better-enums to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

IF( UNIX )
  INCLUDE( vendor-libs/openal )
ENDIF()

SET( BUILD_SHARED_LIBS OFF )
ADD_SUBDIRECTORY( "${CANCELLAR_BUILD_VENDOR_DIR}/SFML" )

#INTERNAL_PRESET_DEPENDENCY ( sfml-graphics )
TARGET_INCLUDE_DIRECTORIES( "sfml-graphics" INTERFACE "${CANCELLAR_BUILD_VENDOR_DIR}/SFML/include/" )
