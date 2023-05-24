#!/bin/bash
source "cbuild/init.sh"

target_file="$1"
touch ".rebuild_$target_file.tmp"
rm -fv "$OBJDIR/libs/$target_file.a"
myprint "${YELLOW}dependency ${WHITE}$target_file ${YELLOW}will be rebuilt with the next build task"
