# Adds better-enums to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( third-parties/third-party-helper )

IF( UNIX )
  INCLUDE( third-parties/openal )
ENDIF()

SET( BUILD_SHARED_LIBS OFF )
ADD_SUBDIRECTORY( "${CANCELLAR_BUILD_THIRD_PARTY_DIR}/SFML" )

#INTERNAL_PRESET_DEPENDENCY ( sfml-graphics )
TARGET_INCLUDE_DIRECTORIES( "sfml-graphics" INTERFACE "${CANCELLAR_BUILD_THIRD_PARTY_DIR}/SFML/include/" )
