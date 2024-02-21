#!/usr/bin/bash

try_delete_dir_or_file "$OBJDIR"
try_delete_dir_or_file "$OUTDIR"
myprint "${WHITE}deleting build logs"
rm -rf *.log

for tmpfile in $(ls -a | grep -e '\.rebuild.*\.tmp'); do
    try_delete_dir_or_file "$tmpfile"
done

set +e
OLDIFS="$IFS"
IFS=$'\n'
cd "$DEPS_BASEDIR"
for dep in $DEPS; do
    dep_dir=$(echo ${dep/=*/} | tr -d '[:blank:]')
    myprint "${CYAN}--------------[$dep_dir]--------------"
    cd "$dep_dir"
    make clean
    cd ..
done
IFS="$OLDIFS"
cd ..
set -e