#!/bin/bash

source cbuild/colors.sh
source cbuild/functions.sh

function create_default_config(){
    if [ -f "default.config" ]; then
        cp default.config .config
    else
        cp cbuild/default.config .config
    fi
    myprintf "${YELLOW}Default config created.\nEdit it.\n"
}

#.config
if [ ! -f ".config" ]; then
    myprintf "${YELLOW}./.config doesn't exist\n"
    create_default_config
    exit
fi
source .config

#version check
if [ ! $CONFIG_VER -eq 2 ]; then
    myprintf "${RED}Your config version isn't correct\n"
    while true; do
        myprintf "${WHITE}Backup current config and create default one? (y/n) "
        read answ
        case $answ in
            [Yy] ) 
                cp .config .config.backup
                create_default_config
                exit;;
            [Nn] ) exit;;
            * ) myprintf "${RED}incorrect answer\n";;
        esac
    done
fi
