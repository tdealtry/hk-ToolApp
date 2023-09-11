
# Definition of ToolChain
# Some hack to build the ToolChain library whose source files exist in the ToolFrameworkCore library
set (TOOLCHAIN_SRC ${ToolFrameworkCore_SRC_DIR}/ToolChain.cpp)
pbuilder_library(
        TARGET HKToolChain
        SOURCES ${TOOLCHAIN_SRC}
        PROJECT_LIBRARIES HKFactory
        PUBLIC_EXTERNAL_LIBRARIES ToolFrameworkCore::ToolFrameworkCore hk-DataModel::DataModel
        PRIVATE_EXTERNAL_LIBRARIES ${PRIVATE_EXT_LIBS}
)
# Exporting library
pbuilder_component_install_and_export(
        COMPONENT Library
        LIBTARGETS HKToolChain
)
# End of hack

add_subdirectory(Factory)

# Definition of main app
add_subdirectory(app)

