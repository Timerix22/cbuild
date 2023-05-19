#!/bin/bash

source cbuild/colors.sh

uname_rezult="$(uname -o)"
myprint "${GRAY}uname rezult: '$uname_rezult'"

case "$uname_rezult" in
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
        error "unknown operating system: $uname_rezult"
        ;;
esac

myprint "${GREEN}detected OS: $OS"
