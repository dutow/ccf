# Adds better-enums to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

ADD_SUBDIRECTORY( "${CANCELLAR_BUILD_VENDOR_DIR}/libsqlite3" )

APPEND_VENDOR_INCLUDES( "${CANCELLAR_BUILD_VENDOR_DIR}/libsqlite3/" )
APPEND_VENDOR_LIBRARIES( sqlite3 )

