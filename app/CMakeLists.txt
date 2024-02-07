file(GLOB_RECURSE EXE_SRC RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.cpp")

pbuilder_executables (
        TARGETS_VAR progams
        SOURCES ${EXE_SRC}
        PROJECT_LIBRARIES HKToolChain
        PUBLIC_EXTERNAL_LIBRARIES ${PUBLIC_EXT_LIBRARIES} # should contain at least ToolFrameworkCore::ToolFrameworkCore and hk-DataModel::DataModel
        PRIVATE_EXTERNAL_LIBRARIES ${PRIVATE_EXT_LIBS}
)

pbuilder_component_install_and_export(
        COMPONENT Executable
        EXETARGETS ${progams}
)