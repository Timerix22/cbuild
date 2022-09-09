#!/bin/bash

source cbuild/colors.sh
source cbuild/functions.sh

#config
if [ ! -f ".config" ]; then
    print "${YELLOW}./.config doesn't exist\n"
    if [ -f "default.config.sh" ]; then
        cp default.config.sh .config
    else
        cp cbuild/default.config.sh .config
    fi
    print "${YELLOW}Default config created.\nEdit it's values.\n"
    exit
fi
source .config
