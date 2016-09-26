# Adds better-enums to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

SET( BUILD_SHARED_LIBS OFF )
ADD_SUBDIRECTORY( "${CANCELLAR_BUILD_VENDOR_DIR}/SFML" )

APPEND_VENDOR_INCLUDES( "${CANCELLAR_BUILD_VENDOR_DIR}/SFML/include" )
APPEND_VENDOR_LIBRARIES( sfml-graphics )

