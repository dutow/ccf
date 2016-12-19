# Adds better-enums to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

ADD_SUBDIRECTORY( "${CANCELLAR_BUILD_VENDOR_DIR}/libsqlite3" )
# TODO: fix it in the library cmake
TARGET_INCLUDE_DIRECTORIES( sqlite3 INTERFACE "${CANCELLAR_BUILD_VENDOR_DIR}/libsqlite3/" )
INTERNAL_PRESET_DEPENDENCY( sqlite3 )
