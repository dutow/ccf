# Adds range-v3 to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( third-parties/third-party-helper )

INTERNAL_DEFAULT_SINGLE_HEADER_ONLY_LIBRARY( "range-v3" "range-v3/include" )

