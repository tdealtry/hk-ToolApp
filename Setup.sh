#!/bin/bash

#Application path location of applicaiton

ToolFrameworkPath=/usr/local/hk/ToolFrameworkCore/src/lib

export LD_LIBRARY_PATH=`pwd`/lib:`pwd`/hk-DataModel:$ToolFrameworkPath:$LD_LIBRARY_PATH

for path in `ls -d UserTools/*/`
do
 export LD_LIBRARY_PATH=`pwd`/$path:$LD_LIBRARY_PATH
done

export SEGFAULT_SIGNALS="all"

export TOOLAPPDIR=/usr/local/hk/hk-ToolApp
export DATAMODELDIR=/usr/local/hk/hk-ToolApp/hk-DataModel
export GHOSTWCSIMDIR=/usr/local/hk/hk-ToolApp/UserTools/ImportedTools/GHOST-WCSim
cd $GHOSTWCSIMDIR/OriginalWCSim_build; source ./this_wcsim.sh; cd -

