
INCLUDE( include_guard )
INCLUDE_GUARD()

INCLUDE( preset/basic )

DEFINE_BUILD_PRESET( "EXTRA" )

# additional 3rd party libraries
INCLUDE( vendor-libs/boost )

INCLUDE( vendor-libs/jeayeson )
INCLUDE( vendor-libs/ticpp )
INCLUDE( vendor-libs/rang )
INCLUDE( vendor-libs/simple-web-server )
INCLUDE( vendor-libs/sqlite3 )
INCLUDE( vendor-libs/sqlpp11 )
INCLUDE( vendor-libs/sqlpp11-sqlite3 )
INCLUDE( vendor-libs/lua )
INCLUDE( vendor-libs/selene )
