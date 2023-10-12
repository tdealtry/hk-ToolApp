file(GLOB_RECURSE EXE_SRC RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.cpp")

pbuilder_executables (
        TARGETS_VAR progams
        SOURCES ${EXE_SRC}
        PROJECT_LIBRARIES ToolFrameworkCore::ToolFrameworkCore HKToolChain
)

pbuilder_component_install_and_export(
        COMPONENT Executable
        EXETARGETS ${progams}
)