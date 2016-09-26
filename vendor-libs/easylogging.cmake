# Adds easyloggingpp to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

INTERNAL_DEFAULT_SINGLE_HEADER_ONLY_LIBRARY( "easylogging++" "easyloggingpp/src" )

ADD_DEFINITIONS(-DELPP_THREAD_SAFE)