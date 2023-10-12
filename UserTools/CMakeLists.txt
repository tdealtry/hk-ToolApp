
# Definition of ToolChain
# Some hack to build the ToolChain library whose source files exist in the ToolFrameworkCore library
set (TOOLCHAIN_SRC ${ToolFrameworkCore_SRC_DIR}/ToolChain.cpp)
pbuilder_library(
        TARGET HKToolChain
        SOURCES ${TOOLCHAIN_SRC}
        PROJECT_LIBRARIES HKFactory
        PUBLIC_EXTERNAL_LIBRARIES ${PUBLIC_EXT_LIBRARIES} # should contain at least ToolFrameworkCore::ToolFrameworkCore and hk-DataModel::DataModel
        PRIVATE_EXTERNAL_LIBRARIES ${PRIVATE_EXT_LIBS}
)
# Exporting library
pbuilder_component_install_and_export(
        COMPONENT Library
        LIBTARGETS HKToolChain
)
# End of hack

# Find all the local tools to be compiled with hk-ToolApp
MACRO(SUBDIRLIST result curdir)
    FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
    SET(dirlist "")
    FOREACH(child ${children})
        IF(IS_DIRECTORY ${curdir}/${child}
                AND NOT "${child}" STREQUAL "template"
                AND NOT "${child}" STREQUAL "Factory"
                AND NOT "${child}" STREQUAL "InactiveTools"
        )
            LIST(APPEND dirlist ${child})
        ENDIF()
    ENDFOREACH()
    SET(${result} ${dirlist})
ENDMACRO()

SUBDIRLIST(SUBDIRS ${CMAKE_CURRENT_SOURCE_DIR})

MESSAGE(STATUS "List of tools dir to be added: ${SUBDIRS}")
FOREACH (dir ${SUBDIRS})
    hk_add_tool(${dir})
    list( APPEND PUBLIC_EXT_LIBS ${dir})
ENDFOREACH ()


add_subdirectory(Factory)
