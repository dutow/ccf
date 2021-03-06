# Common third-party related macros

INCLUDE_GUARD()

MACRO( DEFINE_BUILD_PRESET PRESET_NAME)
  SET( CANCELLAR_CURRENT_PRESET "${PRESET_NAME}")
  ADD_LIBRARY( "PRESET_${PRESET_NAME}" INTERFACE )
  ADD_LIBRARY( "PRESET_${PRESET_NAME}_TEST" INTERFACE )
  TARGET_LINK_LIBRARIES( "PRESET_${CANCELLAR_CURRENT_PRESET}_TEST" INTERFACE "PRESET_${CANCELLAR_CURRENT_PRESET}" )
ENDMACRO()

MACRO( INTERNAL_PRESET_DEPENDENCY LIBNAME )
  TARGET_LINK_LIBRARIES( "PRESET_${CANCELLAR_CURRENT_PRESET}" INTERFACE "${LIBNAME}" )
ENDMACRO()

MACRO( ADD_THIRD_PARTY_INCLUDES )
  INCLUDE_DIRECTORIES( ${CANCELLAR_THIRD_PARTY_INCLUDES} )
ENDMACRO()

MACRO( ADD_TEST_INCLUDES )
  INCLUDE_DIRECTORIES( ${CANCELLAR_TEST_INCLUDES} )
ENDMACRO()

MACRO( APPEND_THIRD_PARTY_LIBRARIES )
  LIST( APPEND CANCELLAR_THIRD_PARTY_LIBRARIES ${ARGV} )
ENDMACRO()

MACRO( APPEND_TEST_THIRD_PARTY_LIBRARIES )
  LIST( APPEND CANCELLAR_TEST_THIRD_PARTY_LIBRARIES ${ARGV} )
ENDMACRO()

MACRO ( __INTERNAL_SINGLE_HEADER_ONLY NAME THIRD_PARTY_DIR )
  IF( NOT EXISTS "${CANCELLAR_BUILD_THIRD_PARTY_DIR}${THIRD_PARTY_DIR}/" )
    MESSAGE( FATAL_ERROR "${NAME} diretory doesn't exists: ${CANCELLAR_BUILD_THIRD_PARTY_DIR}${THIRD_PARTY_DIR}!" )
  ENDIF()
  
  ADD_LIBRARY( "${NAME}" INTERFACE )
  TARGET_INCLUDE_DIRECTORIES( "${NAME}" INTERFACE "${CANCELLAR_BUILD_THIRD_PARTY_DIR}${THIRD_PARTY_DIR}/" )
  SET(_argn_list "${ARGN}")
  FOREACH(arg IN LISTS _argn_list)
    TARGET_INCLUDE_DIRECTORIES( "${NAME}" INTERFACE "${CANCELLAR_BUILD_THIRD_PARTY_DIR}${arg}/" )
  ENDFOREACH()
ENDMACRO()

MACRO( INTERNAL_DEFAULT_SINGLE_HEADER_ONLY_LIBRARY NAME THIRD_PARTY_DIR )
  __INTERNAL_SINGLE_HEADER_ONLY( "${NAME}" "${THIRD_PARTY_DIR}" ${ARGN})
  TARGET_LINK_LIBRARIES( "PRESET_${CANCELLAR_CURRENT_PRESET}" INTERFACE "${NAME}" )
ENDMACRO()

MACRO( INTERNAL_HEADER_ONLY_LIBRARY NAME THIRD_PARTY_DIR )
  __INTERNAL_SINGLE_HEADER_ONLY( "${NAME}" "${THIRD_PARTY_DIR}" ${ARGN})
  TARGET_LINK_LIBRARIES( "PRESET_${CANCELLAR_CURRENT_PRESET}" INTERFACE "${NAME}" )
ENDMACRO()

MACRO( INTERNAL_TEST_SINGLE_HEADER_ONLY_LIBRARY NAME THIRD_PARTY_DIR )
  __INTERNAL_SINGLE_HEADER_ONLY( "${NAME}" "${THIRD_PARTY_DIR}" ${ARGN})
  TARGET_LINK_LIBRARIES( "PRESET_${CANCELLAR_CURRENT_PRESET}_TEST" INTERFACE "${NAME}" )
ENDMACRO()

