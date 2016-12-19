
INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

ADD_SUBDIRECTORY( "${CANCELLAR_BUILD_VENDOR_DIR}/sqlpp11-connector-sqlite3" )

# TODO: move to it's own file
INTERNAL_DEFAULT_SINGLE_HEADER_ONLY_LIBRARY( "date" "date" )

TARGET_INCLUDE_DIRECTORIES(  sqlpp11-connector-sqlite3 INTERFACE "${CANCELLAR_BUILD_VENDOR_DIR}/sqlpp11-connector-sqlite3/include/" )
TARGET_LINK_LIBRARIES( sqlpp11-connector-sqlite3 date )

INTERNAL_PRESET_DEPENDENCY( sqlpp11-connector-sqlite3 )