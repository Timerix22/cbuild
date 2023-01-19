#!/bin/bash

source cbuild/colors.sh

uname_rezult=$(uname -o);
printf "${GRAY}uname rezult: '$uname_rezult'\n"

case $uname_rezult in
    Msys | Cygwin | "MS/Windows")
        OS=WINDOWS
        ;;
    GNU/Linux)
        OS=LINUX
        ;;
    FreeBSD)
        OS=FREEBSD
        ;;
    Darwin)
        OS=MACOS
        ;;
    *)
        printf "${RED}unknown operating system: $uname_rezult\n"
        exit 1
        ;;
esac

printf "${GREEN}detected OS: $OS\n"
