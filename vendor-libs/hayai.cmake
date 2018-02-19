# Adds GSL to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

INTERNAL_DEFAULT_SINGLE_HEADER_ONLY_LIBRARY( "hayai" "hayai/src" )

