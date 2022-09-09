#!/bin/bash

tabs 4

source cbuild/colors.sh
source cbuild/functions.sh

#config
if [ ! -f ".config" ]; then
    print "${YELLOW}./.config doesn't exist\n"
    cp cbuild/default.config.sh .config
    print "${YELLOW}Default config created.\nEdit it's values and continue."
    while true; do
        print "${WHITE}continue? (y/n) "
        read answ
        case $answ in
            [Yy] ) break;;
            [Nn] ) exit;;
            * ) print "${RED}incorrect answer\n";;
        esac
    done
fi


source .config
