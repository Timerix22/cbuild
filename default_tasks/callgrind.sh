#!/bin/bash

cd "$OUTDIR"

# deleting all files except excutable
echo "$(find . ! -name $EXEC_FILE -type f -delete)"

# executing file with callgrind
myprint "${BLUE}executing $OUTDIR/$EXEC_FILE"
valgrind --tool=callgrind --callgrind-out-file=callgrind.out ./$EXEC_FILE > exec.log
myprint "${GREEN}execution log saved to ${CYAN}$OUTDIR/exec.log"
# exit 0
# generating function call graph
myprint "${BLUE}generating function call graph..."
gprof2dot -f callgrind callgrind.out > gprof2dot.graph
dot gprof2dot.graph -Tpng -Gdpi=300 -o gprof2dot.png
myprint "${GREEN}function call graph saved to ${CYAN}$OUTDIR/gprof2dot.png"

cd ../..
