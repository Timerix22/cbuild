#!/bin/bash

cd "$OUTDIR"

# deleting all files except excutable
echo "$(find . ! -name $EXEC_FILE -type f -delete)"

# executing file compiled with -pg
myprint "${BLUE}executing $OUTDIR/$EXEC_FILE"
./$EXEC_FILE > exec.log
myprint "${GREEN}execution log saved to ${CYAN}$OUTDIR/exec.log"

# generating function call graph
myprint "${BLUE}generating function call graph..."
gprof ./$EXEC_FILE > gprof.log
gprof2dot gprof.log > gprof2dot.graph
dot gprof2dot.graph -Tpng -Gdpi=300 -o gprof2dot.png
myprint "${GREEN}function call graph saved to ${CYAN}$OUTDIR/gprof2dot.png"

cd ../..
