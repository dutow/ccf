# Adds better-enums to the default libs / incldues

INCLUDE_GUARD()
INCLUDE( third-parties/third-party-helper )
INCLUDE( third-parties/python_interpreter )

OPTION(WITH_CATCH_SPLIT "Use multi-header Catch2" OFF)


INTERNAL_TEST_SINGLE_HEADER_ONLY_LIBRARY( "catch" "Catch/single_include" )
IF (WITH_CATCH_SPLIT)
  SET(CATCH_SRC_DIR "${CANCELLAR_BUILD_THIRD_PARTY_DIR}/Catch/include")

  FILE( GLOB_RECURSE CATCH_SOURCES 
    "${CATCH_SRC_DIR}/*.h"
    "${CATCH_SRC_DIR}/*.cpp"
    "${CATCH_SRC_DIR}/*.hpp"
  )
  ADD_CUSTOM_COMMAND(
    OUTPUT "${CANCELLAR_BUILD_THIRD_PARTY_DIR}/Catch/single_include/catch.hpp"
    COMMAND ${PYTHON_EXECUTABLE} scripts/generateSingleHeader.py
    WORKING_DIRECTORY "${CANCELLAR_BUILD_THIRD_PARTY_DIR}/Catch"
    DEPENDS "${CATCH_SOURCES}"
    COMMENT "Regenerating Catch2 headers"
  )

  ADD_CUSTOM_TARGET("catch-builder" ALL 
    COMMAND echo Dummy target to check for Catch2 changes
    SOURCES "${CANCELLAR_BUILD_THIRD_PARTY_DIR}/Catch/single_include/catch.hpp"
  )
  ADD_DEPENDENCIES( "catch" "catch-builder" )
ENDIF ()


