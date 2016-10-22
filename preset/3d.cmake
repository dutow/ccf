
INCLUDE( include_guard )
INCLUDE_GUARD()

INCLUDE( preset/basic )

# additional 3rd party libraries
INCLUDE( vendor-libs/glm )
INCLUDE (vendor-libs/opengl )

IF( CANCELLAR_PLATFORM_LINUX )
  INCLUDE (vendor-libs/x11 )
  INCLUDE (vendor-libs/xcb )
  INCLUDE (vendor-libs/x11_xcb )
ENDIF()
