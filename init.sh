#!/bin/bash

source cbuild/colors.sh
source cbuild/functions.sh

function create_default_config(){
    if [ -f "default.config" ]; then
        cp default.config .config
    else
        cp cbuild/default.config .config
    fi
    printf "${YELLOW}Default config created.\nEdit it.\n"
}

#.config
if [ ! -f ".config" ]; then
    printf "${YELLOW}./.config doesn't exist\n"
    create_default_config
    exit
fi
source .config

#version check
if [ ! $CONFIG_VER -eq 2 ]; then
    printf "${RED}Your config version isn't correct\n"
    while true; do
        printf "${WHITE}Backup current config and create default one? (y/n) "
        read answ
        case $answ in
            [Yy] ) 
                cp .config .config.backup
                create_default_config
                exit;;
            [Nn] ) exit;;
            * ) printf "${RED}incorrect answer\n";;
        esac
    done
fi
