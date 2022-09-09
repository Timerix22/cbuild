#!/bin/bash

tabs 4
TASK=$1
printf "${CYAN}===========[$TASK]===========\n"
source cbuild/init.sh

#pre_build
clear_dir $OBJDIR

if [ -f "$PRE_BUILD_SCRIPT" ]; then
    printf "${BLUE}executing $PRE_BUILD_SCRIPT"
    source "$PRE_BUILD_SCRIPT"
fi

source $TASK_SCRIPT
printf "${GRAY}"
