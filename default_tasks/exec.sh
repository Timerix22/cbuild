#!/bin/bash

source cbuild/init.sh

print "${CYAN}================[exec]================\n"
cd $OUTDIR
./$EXEC_FILE
cd ..
