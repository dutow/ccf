
INCLUDE( include_guard )
INCLUDE_GUARD()

INCLUDE( preset/basic )

# additional 3rd party libraries
INCLUDE( vendor-libs/glm )

IF( CANCELLAR_PLATFORM_LINUX )
  INCLUDE( vendor-libs/openal )
ENDIF()

INCLUDE( vendor-libs/sfml )
