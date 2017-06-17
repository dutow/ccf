
INCLUDE( include_guard )
INCLUDE_GUARD()

IF( NOT DEFINED CANCELLAR_BUILD_SOURCE_DIR )
  SET( CANCELLAR_BUILD_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}" )
ENDIF()

IF( NOT DEFINED CANCELLAR_BUILD_BINARY_DIR )
  SET( CANCELLAR_BUILD_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}" )
ENDIF()

IF( NOT DEFINED CANCELLAR_BUILD_VENDOR_DIR )
  SET( CANCELLAR_BUILD_VENDOR_DIR "${CANCELLAR_BUILD_SOURCE_DIR}/vendor/" )
ENDIF()

## Common settings
ENABLE_TESTING()

INCLUDE( "vendor-libs/vendor-helper" )
DEFINE_BUILD_PRESET( "BASIC" )

# for vim youcompleteme
SET ( CMAKE_EXPORT_COMPILE_COMMANDS 1 )

## Common build configuration
INCLUDE( GroupInVisualStudio )
INCLUDE( BuildHelpers )
INCLUDE( CancellarConfig )
INCLUDE( CompilerConfig )
#INCLUDE( MagicAssets )

# 3rd party libraries
INCLUDE( vendor-libs/threads )
INCLUDE( vendor-libs/easylogging )
INCLUDE( vendor-libs/gsl )
#INCLUDE( vendor-libs/eggs-variant )
INCLUDE( vendor-libs/range-v3 )
INCLUDE( vendor-libs/better-enums )
#INCLUDE( vendor-libs/optional )
INCLUDE( vendor-libs/rang )

# test framework
INCLUDE( vendor-libs/catch )
INCLUDE( vendor-libs/fakeit-catch )

