# Adds better-enums to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( vendor-libs/vendor-helper )

OPTION(WITH_FAKEIT_SPLIT "Use multi-header FakeIt" OFF)

IF (WITH_FAKEIT_SPLIT)
  INTERNAL_TEST_SINGLE_HEADER_ONLY_LIBRARY( "FakeIt" "FakeIt/include/" "FakeIt/config/catch" )
ELSE()
  INTERNAL_TEST_SINGLE_HEADER_ONLY_LIBRARY( "FakeIt" "FakeIt/single_header/catch" )
ENDIF()
