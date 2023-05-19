#!/bin/bash

cd "$OUTDIR"
rm -f "valgrind.log"
set +e
valgrind --log-file=valgrind.log  $VALGRIND_ARGS ./$EXEC_FILE
set -e
[ -f "valgrind.log" ] && cat "valgrind.log" || error "valgrind exited with errors"
myprint "${GREEN}valgrind log saved to ${CYAN}$OUTDIR/valgrind.log"
cd ..
