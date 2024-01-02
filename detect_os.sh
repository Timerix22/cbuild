#!/bin/bash

source cbuild/colors.sh

uname_result="$(uname -o)"
myprint "${GRAY}uname result: '$uname_result'"

case "$uname_result" in
    Msys | Cygwin | "MS/Windows")
        OS=WINDOWS
        ;;
    Linux | GNU/Linux | Android)
        OS=LINUX
        ;;
    FreeBSD)
        OS=FREEBSD
        ;;
    Darwin)
        OS=MACOS
        ;;
    *)
        error "unknown operating system: $uname_result"
        ;;
esac

myprint "${GREEN}detected OS: $OS"
