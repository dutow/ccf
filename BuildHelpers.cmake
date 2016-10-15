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

MACRO( ADD_TARGET )

  FILE( GLOB_RECURSE 
			${BUILD_SCOPE}-headers *.hxx 
			"${CMAKE_CURRENT_BINARY_DIR}/*.hxx" 
			"${PROJECT_SOURCE_DIR}/assets/${BUILD_SCOPEDIR}/*.glsl" 
	  )

  FOREACH(src ${ARGV})
    LIST(APPEND ${BUILD_SCOPE}-sources "${CMAKE_CURRENT_SOURCE_DIR}/${src}")
  ENDFOREACH()
  LIST(APPEND ${BUILD_SCOPE}-all ${${BUILD_SCOPE}-sources})  
  LIST(APPEND ${BUILD_SCOPE}-all ${${BUILD_SCOPE}-headers})
  ADD_EXECUTABLE( ${BUILD_SCOPE} ${${BUILD_SCOPE}-all} )
  
  GroupInVisualStudio()
  #MagicAssets()
  
  # INSTALLING
  # INSTALL( TARGETS "${BUILD_SCOPE}" RUNTIME DESTINATION ${BUILD_SCOPEDIR})
  # INSTALL( DIRECTORY "${PROJECT_SOURCE_DIR}/assets/${BUILD_SCOPEDIR}/" DESTINATION "${BUILD_SCOPEDIR}/assets" )
  # TODO: install it!
  #  INSTALL( FILES ${${BUILD_SCOPE}-headers} DESTINATION "include/${BUILD_SCOPEDIR}" )
  #  INSTALL( TARGETS "${BUILD_SCOPE}" LIBRARY DESTINATION "lib" ARCHIVE DESTINATION "lib" )
ENDMACRO( ADD_TARGET )

MACRO( SET_MAIN_TARGET )
  INSTALL( TARGETS "${BUILD_SCOPE}" DESTINATION "bin" )
  SET_TARGET_PROPERTIES( "${BUILD_SCOPE}" PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin" )
  # TODO: copy assets
ENDMACRO()

MACRO( ADD_TEST_TARGET )
  ADD_TARGET( ${ARGV} )
  ADD_TEST(NAME "${BUILD_SCOPE}" COMMAND "${BUILD_SCOPE}" )
ENDMACRO()

MACRO( LINK_TARGET )
  SET( MYLIBS ${CANCELLAR_VENDOR_LIBRARIES} ${ARGV} )
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
  ADD_LIBRARY( ${BUILD_SCOPE} ${${BUILD_SCOPE}-all})
  
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
