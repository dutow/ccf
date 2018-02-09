# Adds the standalone ASIO as an interface library

INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

INTERNAL_HEADER_ONLY_LIBRARY( "asio" "asio/asio/include" )

