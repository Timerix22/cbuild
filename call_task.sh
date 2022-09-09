#!/bin/bash

tabs 4
TASK=$1
myprint "${CYAN}===========[$TASK]===========\n"
source cbuild/init.sh

#pre_build
clear_dir $OBJDIR
clear_dir $OUTDIR
if [ -f "$PRE_BUILD_SCRIPT" ]; then
    myprint "${BLUE}executing $PRE_BUILD_SCRIPT"
    source "$PRE_BUILD_SCRIPT"
fi

./$TASK_SCRIPT
