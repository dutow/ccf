# 
# Helper functions for the cmake build process to build executables or static libraries
#
# Usage:
#
# MODIFY_SCOPE( name ) in source directories
#
# ADD_TARGET( ... files ... ) for an executable
# LINK_TARGET( ... deps ... ) for executable dependencies
# ADD_STATIC_LIB( .. files ... ) to build a static lib
#

# TODO: add errors for  missing cpp files / wrong directory structure!

MACRO( MODIFY_SCOPE addto )
  IF( NOT BUILD_SCOPE )
    SET ( BUILD_SCOPE ${addto} )
    SET ( BUILD_SCOPEDIR ${addto} )
  ELSE( NOT BUILD_SCOPE )
    SET( BUILD_SCOPE "${BUILD_SCOPE}-${addto}" )
    SET( BUILD_SCOPEDIR "${BUILD_SCOPEDIR}/${addto}" )
  ENDIF( NOT BUILD_SCOPE )
ENDMACRO( MODIFY_SCOPE )

FUNCTION( ADD_TARGET )

  FILE( GLOB_RECURSE 
			${BUILD_SCOPE}-headers *.hxx 
			"${CMAKE_CURRENT_BINARY_DIR}/*.hxx" 
      "${CMAKE_CURRENT_SOURCE_DIR}/../internal_include/*.hxx"
			"${PROJECT_SOURCE_DIR}/assets/${BUILD_SCOPEDIR}/*.glsl" 
    )
    

  FOREACH(src ${ARGV})
    LIST(APPEND ${BUILD_SCOPE}-sources "${CMAKE_CURRENT_SOURCE_DIR}/${src}")
  ENDFOREACH()
  LIST(APPEND ${BUILD_SCOPE}-all ${${BUILD_SCOPE}-sources})  
  LIST(APPEND ${BUILD_SCOPE}-all ${${BUILD_SCOPE}-headers})
  ADD_EXECUTABLE( ${BUILD_SCOPE} ${${BUILD_SCOPE}-all} )
  
  IF( MSVC )
    target_compile_options(${BUILD_SCOPE} PRIVATE "/std:c++latest") # allow experimental C++17
  ENDIF()
  
  GroupInVisualStudio()
  #MagicAssets()
  
  # INSTALLING
  # INSTALL( TARGETS "${BUILD_SCOPE}" RUNTIME DESTINATION ${BUILD_SCOPEDIR})
  # INSTALL( DIRECTORY "${PROJECT_SOURCE_DIR}/assets/${BUILD_SCOPEDIR}/" DESTINATION "${BUILD_SCOPEDIR}/assets" )
  # TODO: install it!
  #  INSTALL( FILES ${${BUILD_SCOPE}-headers} DESTINATION "include/${BUILD_SCOPEDIR}" )
  #  INSTALL( TARGETS "${BUILD_SCOPE}" LIBRARY DESTINATION "lib" ARCHIVE DESTINATION "lib" )
ENDFUNCTION( ADD_TARGET )

MACRO( SET_MAIN_TARGET )
  IF( "${ARGV0}" STREQUAL "" )
    SET( "${BUILD_SCOPE}_BINARY" "bin" )
  ELSE()
    SET( "${BUILD_SCOPE}_BINARY" "${ARGV0}" )
  ENDIF()
  INSTALL( TARGETS "${BUILD_SCOPE}" DESTINATION "${${BUILD_SCOPE}_BINARY}" )
  SET_TARGET_PROPERTIES( "${BUILD_SCOPE}" PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${${BUILD_SCOPE}_BINARY}" )
  # TODO: copy assets
ENDMACRO()

MACRO( ADD_MAIN_TARGET )
  ADD_TARGET( ${ARGV} )
  SET_MAIN_TARGET()
ENDMACRO()

MACRO( ADD_TEST_TARGET )
  ADD_TARGET( ${ARGV} )
  SET_MAIN_TARGET( "test" )
  ADD_TEST(NAME "${BUILD_SCOPE}" COMMAND "${BUILD_SCOPE}" )
ENDMACRO()

MACRO( LINK_TARGET )
  SET( MYLIBS ${ARGV} ${CANCELLAR_VENDOR_LIBRARIES} ${CONAN_LIBS} )
  TARGET_LINK_LIBRARIES(${BUILD_SCOPE} ${MYLIBS})
ENDMACRO( LINK_TARGET )

MACRO( ADD_STATIC_LIB )
  FILE( GLOB_RECURSE ${BUILD_SCOPE}-headers 
		*.hxx 
		"${CMAKE_CURRENT_BINARY_DIR}/*.hxx" 		
		"${CMAKE_CURRENT_SOURCE_DIR}/../include/*.hxx" 
		"${CMAKE_CURRENT_SOURCE_DIR}/../internal_include/*.hxx" 
		"${CMAKE_PROJECT_SOURCE_DIR}/assets/${BUILD_SCOPEDIR}*.glsl" 
		)

  FOREACH(src ${ARGV})
    LIST(APPEND ${BUILD_SCOPE}-sources "${CMAKE_CURRENT_SOURCE_DIR}/${src}")
  ENDFOREACH()
  LIST(APPEND ${BUILD_SCOPE}-all ${${BUILD_SCOPE}-sources})  
  LIST(APPEND ${BUILD_SCOPE}-all ${${BUILD_SCOPE}-headers})  
  ADD_LIBRARY( ${BUILD_SCOPE} STATIC ${${BUILD_SCOPE}-all})
  SET_PROPERTY(TARGET ${BUILD_SCOPE} PROPERTY POSITION_INDEPENDENT_CODE ON)

  IF( MSVC )
    target_compile_options(${BUILD_SCOPE} PRIVATE "/std:c++latest") # allow experimental C++17
  ENDIF()

  GroupInVisualStudio()
  #MagicAssets()
  
  # TODO
  #  INSTALL( FILES ${${BUILD_SCOPE}-headers} DESTINATION "include/${BUILD_SCOPEDIR}" )
  #  INSTALL( TARGETS "${BUILD_SCOPE}" LIBRARY DESTINATION "lib" ARCHIVE DESTINATION "lib" )
ENDMACRO( ADD_STATIC_LIB )

# TODO: move this to a better place
  IF ( CMAKE_VS_PLATFORM_TOOLSET MATCHES "LLVM-vs2014" )
	SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -Qunused-arguments" )
  ENDIF ()
