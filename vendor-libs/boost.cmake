# Adds better-enums to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

# Note: this requies a boost built by hand
IF( NOT DEFINED BOOST_ROOT )
  SET ( BOOST_ROOT "${CANCELLAR_BUILD_VENDOR_DIR}/boost-install" )
ENDIF()
SET ( Boost_USE_STATIC_LIBS ON )
INCLUDE( FindBoost )
# Build only the libraries that make sense with C++14
FIND_PACKAGE( Boost REQUIRED COMPONENTS system thread context fiber program_options filesystem iostreams )

APPEND_VENDOR_INCLUDES( "${Boost_INCLUDE_DIR}" )
APPEND_VENDOR_LIBRARIES( ${Boost_LIBRARIES} )

