#!/bin/bash

cd "$OUTDIR"
valgrind $VALGRIND_ARGS ./$EXEC_FILE
cat "valgrind.log"
myprint "${GREEN}valgrind log saved to ${CYAN}$OUTDIR/exec.log"
cd ..
