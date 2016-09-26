# Common vendor related macros

INCLUDE_GUARD()

MACRO( ADD_VENDOR_INCLUDES )
  INCLUDE_DIRECTORIES( ${CANCELLAR_VENDOR_INCLUDES} )
ENDMACRO()

MACRO( ADD_TEST_INCLUDES )
  INCLUDE_DIRECTORIES( ${CANCELLAR_TEST_INCLUDES} )
ENDMACRO()

# Helper to include a required, single include directory, header only library into the list of default libraries
MACRO( INTERNAL_DEFAULT_SINGLE_HEADER_ONLY_LIBRARY NAME VENDOR_DIR )
IF( NOT EXISTS "${CANCELLAR_BUILD_VENDOR_DIR}${VENDOR_DIR}/" )
  MESSAGE( FATAL_ERROR "${NAME} diretory doesn't exists: ${CANCELLAR_BUILD_VENDOR_DIR}${VENDOR_DIR}!" )
ENDIF()
LIST(APPEND CANCELLAR_VENDOR_INCLUDES "${CANCELLAR_BUILD_VENDOR_DIR}${VENDOR_DIR}" )	
ENDMACRO()

# Helper to include a required, single include directory, header only library into the list of test libraries
MACRO( INTERNAL_TEST_SINGLE_HEADER_ONLY_LIBRARY NAME VENDOR_DIR )
IF( NOT EXISTS "${CANCELLAR_BUILD_VENDOR_DIR}${VENDOR_DIR}/" )
  MESSAGE( FATAL_ERROR "${NAME} diretory doesn't exists: ${CANCELLAR_BUILD_VENDOR_DIR}${VENDOR_DIR}!" )
ENDIF()
LIST(APPEND CANCELLAR_TEST_INCLUDES "${CANCELLAR_BUILD_VENDOR_DIR}${VENDOR_DIR}" )	
ENDMACRO()

