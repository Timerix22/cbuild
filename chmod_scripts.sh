#!/bin/bash
SCRIPTS="$(find ./ -name '*.sh')"
for F in $SCRIPTS
do
    echo "$F"
    chmod +x "$F"
done
