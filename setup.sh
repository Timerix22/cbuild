#!/bin/bash

# exit on errors
set -eo pipefail

# help
if [ $# -eq 0 ] || [ "$1" = "h" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ "$1" = "/?" ]; then
    echo "usage: setup.sh [ submodule | standalone ]"
    echo "    submodule  - add to existing git repo as submodule"
    echo "    standalone - keep independent git repo"
fi

case "$1" in
    submodule)
        echo "mode - $1"
        git submodule add cbuild
    ;;
    standalone)
        echo "mode - $1"
    ;;
    *)
        echo "invalid argument: $1"
        exit -1
    ;;
esac

cp cbuild/default.Makefile Makefile
cp cbuild/default.config ./
