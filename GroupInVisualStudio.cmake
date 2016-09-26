# Groups the source files based on their filesystem folders in visual studio
# Based on: http://cmake.3232098.n2.nabble.com/Keep-folder-structure-in-Visual-Studio-Project-generated-with-CMake-td7586044.html

MACRO (GroupInVisualStudio)
	GroupSources (${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR})
	GroupSources_HPP ("${CMAKE_CURRENT_SOURCE_DIR}/../include/" "${CMAKE_CURRENT_SOURCE_DIR}/../include/" "Include")
	GroupSources_HPP ("${CMAKE_CURRENT_SOURCE_DIR}/../internal_include/" "${CMAKE_CURRENT_SOURCE_DIR}/../internal_include/" "InternalInclude")
	GroupSources_HPP (${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR} "Source")
	GroupSources_GLSL ("${PROJECT_SOURCE_DIR}/assets/${BUILD_SCOPEDIR}" "${PROJECT_SOURCE_DIR}/assets/${BUILD_SCOPEDIR}")
ENDMACRO (GroupInVisualStudio)

MACRO (GroupSources rootdir curdir)
	FILE( GLOB children RELATIVE ${curdir} ${curdir}/*)
	
	FOREACH (child ${children})
		IF(IS_DIRECTORY ${curdir}/${child})
			GroupSources(${rootdir} ${curdir}/${child})
		ELSE ()
			STRING (REPLACE ${rootdir} "Source" groupname ${curdir})
			STRING (REPLACE "/" "\\" groupname ${groupname})
			STRING (REPLACE "\\." "" groupname ${groupname})
			SOURCE_GROUP (${groupname} FILES ${curdir}/${child})
		ENDIF ()
	ENDFOREACH ()
ENDMACRO ()

# TODO: refactor
MACRO (GroupSources_HPP rootdir curdir rootType)

	FILE( GLOB children RELATIVE ${curdir} ${curdir}/*)
	
	FOREACH (child ${children})
		IF(IS_DIRECTORY ${curdir}/${child})
			GroupSources_HPP(${rootdir} ${curdir}/${child} ${rootType})
		ENDIF ()
	ENDFOREACH ()
	
	FILE( GLOB children RELATIVE ${curdir} ${curdir}/*.hxx)
	
	FOREACH (child ${children})
		STRING (REPLACE ${rootdir} ${rootType} groupname ${curdir})
		STRING (REPLACE "/" "\\" groupname ${groupname})
		STRING (REPLACE "\\." "" groupname ${groupname})
		SOURCE_GROUP (${groupname} FILES ${curdir}/${child})
	ENDFOREACH ()
ENDMACRO ()

# TODO: refactor
MACRO (GroupSources_GLSL rootdir curdir)
	FILE( GLOB children RELATIVE ${curdir} ${curdir}/*)
	
	FOREACH (child ${children})
		IF(IS_DIRECTORY ${curdir}/${child})
			GroupSources_GLSL(${rootdir} ${curdir}/${child})
		ENDIF ()
	ENDFOREACH ()
	
	FILE( GLOB children RELATIVE ${curdir} ${curdir}/*.glsl)
	
	FOREACH (child ${children})
		STRING (REPLACE ${rootdir} "Shaders" groupname ${curdir})
		STRING (REPLACE "/" "\\" groupname ${groupname})
		STRING (REPLACE "\\." "" groupname ${groupname})
		SOURCE_GROUP (${groupname} FILES ${curdir}/${child})
	ENDFOREACH ()
ENDMACRO ()
