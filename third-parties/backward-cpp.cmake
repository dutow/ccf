# Adds the standalone ASIO as an interface library

INCLUDE_GUARD()
INCLUDE( third-parties/third-party-helper )


INTERNAL_HEADER_ONLY_LIBRARY( "backward-cpp" "backward-cpp" )

IF ( UNIX )
  FIND_PACKAGE( Dwarf REQUIRED )
  FIND_PACKAGE( LibElf REQUIRED )
  TARGET_LINK_LIBRARIES( "backward-cpp" INTERFACE ${LIBDWARF_LIBRARIES} ${LIBELF_LIBRARIES})
  TARGET_INCLUDE_DIRECTORIES( "backward-cpp" INTERFACE ${LIBDWARF_INCLUDE_DIRS} ${LIBELF_INCLUDE_DIRS})
ENDIF ()
