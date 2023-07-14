#!/bin/bash

#Application path location of applicaiton

ToolFrameworkPath=/usr/local/hk/ToolFrameworkCore/src/lib

export LD_LIBRARY_PATH=`pwd`/lib:$ToolFrameworkPath:$LD_LIBRARY_PATH

export SEGFAULT_SIGNALS="all"
