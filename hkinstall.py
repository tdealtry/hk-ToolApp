from hkpilot.utils.cmake import CMake
from hkpilot.utils import fancylogger

import sys, os

logger = fancylogger.getLogger(__name__)

class HKToolApp(CMake):

    def __init__(self, path):
        super().__init__(path)
        self._package_name = "hk-ToolApp"

    def configure(self):
        # We override the configure step to add the symlink to the compiled_tools repository
        logger.info("Adding linkage to compiled tools directory")
        compiledtools_dirname = os.getenv("HK_COMPILEDTOOLS_DIR")
        inactivetools_dirname = os.path.join(self._path, "UserTools", "InactiveTools")
        activetools_dirname = os.path.join(self._path, "UserTools")


        # Find all the inactive tools
        list_inactive_tools = []
        for name in os.listdir(inactivetools_dirname):
            if os.path.isdir(os.path.join(inactivetools_dirname, name)) or os.path.islink(os.path.join(inactivetools_dirname, name)):
                list_inactive_tools.append(name)
        logger.debug(f"List of inactive tools: {list_inactive_tools}")

        # Find all the active tools
        list_active_tools = []
        for name in os.listdir(activetools_dirname):
            if name in ["Factory", "InactiveTools", "template"]:
                continue
            if os.path.isdir(os.path.join(activetools_dirname, name)) or os.path.islink(os.path.join(activetools_dirname, name)):
                list_active_tools.append(name)
        logger.debug(f"List of active tools: {list_active_tools}")
        
        for name in os.listdir(compiledtools_dirname):
            full = os.path.join(compiledtools_dirname, name)
            # only looking for symlink to which we will create another link
            if not os.path.islink(full):
                continue
            # checking the tool is not already active or exists as inactive
            if name in list_inactive_tools:
                logger.debug(f"Tool {name} is already linked as inactive tool")
                continue
            if name in list_active_tools:
                logger.debug(f"Tool {name} is already linked as active tool")
                continue

            symlink = os.path.join(inactivetools_dirname, name)
            logger.info(f"Adding link of tool {name} -> {symlink}")
            os.symlink(full, symlink)
        logger.info("Done with linkage")

        return super().configure()
        