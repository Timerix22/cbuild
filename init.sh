#!/bin/bash

tabs 4

source cbuild/colors.sh
source cbuild/functions.sh

#config
if [ ! -f ".config" ]; then
    print "${YELLOW}./.config doesn't exist\n"
    cp cbuild/default.config.sh .config
    print "${YELLOW}Default config created.\nEdit it's values.\n"
    exit
fi

source .config

#pre_build
if [ -f "$PRE_BUILD_SCRIPT" ]; then
    print "${BLUE}executing $PRE_BUILD_SCRIPT"
    source "$PRE_BUILD_SCRIPT"
fi