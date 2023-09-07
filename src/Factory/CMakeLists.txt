file(GLOB_RECURSE SRC RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.cpp")
file(GLOB_RECURSE HEADERS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.h")

# List of tools that are leaving in libraries and that should be linked into the library
# We prefer being explicit about the tools (one tool per library) and not combine multiple tools into one single library
# Ideally we would like to make them loaded from a configuration file read at compilation time.
set (TOOLS_LIST
        myhklib::DummyTool
        myhklib::WCSimTool
)

pbuilder_library(
        TARGET HKFactory
        SOURCES ${SRC}
#        PROJECT_LIBRARIES DummyTool WCSimTool
        PUBLIC_EXTERNAL_LIBRARIES ToolFrameworkCore::ToolFrameworkCore ${TOOLS_LIST}
        PRIVATE_EXTERNAL_LIBRARIES ${PRIVATE_EXT_LIBS}
)

pbuilder_install_headers(${HEADERS})

# Exporting library
pbuilder_component_install_and_export(
        COMPONENT Library
        LIBTARGETS HKFactory
)