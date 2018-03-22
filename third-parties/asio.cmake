# Adds the standalone ASIO as an interface library

INCLUDE_GUARD()
INCLUDE( third-parties/third-party-helper )

INTERNAL_HEADER_ONLY_LIBRARY( "asio" "asio/asio/include" )

