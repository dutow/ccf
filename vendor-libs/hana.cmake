# Adds Boost::Hana as an interface library

INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

INTERNAL_HEADER_ONLY_LIBRARY( "boost_hana" "hana/include" )
TARGET_COMPILE_DEFINITIONS( "boost_hana" INTERFACE "ASIO_STANDALONE" )

