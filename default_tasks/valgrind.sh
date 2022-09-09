#!/bin/bash

cd $OUTDIR
valgrind $VALGRIND_ARGS ./$EXEC_FILE
cat "valgrind.log"
cd ..
