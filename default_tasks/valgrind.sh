#!/bin/bash

source cbuild/init.sh

print "${CYAN}==============[valgrind]==============\n"
cd $OUTDIR
valgrind $VALGRIND_ARGS ./$EXEC_FILE
cat "valgrind.log"
cd ..
