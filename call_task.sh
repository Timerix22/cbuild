#!/bin/bash

tabs 4
TASK=$1
printf "${CYAN}===========[$TASK]===========\n"
source cbuild/init.sh

clear_dir $OBJDIR

if [ -f "$PRE_TASK_SCRIPT" ]; then
    printf "${BLUE}executing $PRE_TASK_SCRIPT"
    source "$PRE_TASK_SCRIPT"
fi

source $TASK_SCRIPT
printf "${GRAY}"

if [ -f "$POST_TASK_SCRIPT" ]; then
    printf "${BLUE}executing $POST_TASK_SCRIPT"
    source "$POST_TASK_SCRIPT"
fi
