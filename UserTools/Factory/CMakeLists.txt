file(GLOB_RECURSE SRC RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "Factory.cpp")

pbuilder_library(
        TARGET HKFactory
        SOURCES ${SRC}
        PROJECT_LIBRARIES ${TOOLS_LIBS}
        PUBLIC_EXTERNAL_LIBRARIES ${PUBLIC_EXT_LIBS} ${EXT_TOOLS_LIBS}
        PRIVATE_EXTERNAL_LIBRARIES ${PRIVATE_EXT_LIBS}
)

pbuilder_install_headers(${HEADERS})

# Exporting library
pbuilder_component_install_and_export(
        COMPONENT Library
        LIBTARGETS HKFactory
)