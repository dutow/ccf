# Adds better-enums to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

ADD_SUBDIRECTORY( "${CANCELLAR_BUILD_VENDOR_DIR}/lua" )

APPEND_VENDOR_INCLUDES( "${CANCELLAR_BUILD_VENDOR_DIR}/lua/src" )
APPEND_VENDOR_LIBRARIES( liblua )

# HACK: include the directory where luaconf.h is stored
APPEND_VENDOR_INCLUDES( "${CANCELLAR_BUILD_BINARY_DIR}/vendor/lua/" )
