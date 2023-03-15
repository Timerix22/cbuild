#!/bin/bash

cd "$OUTDIR"

# deleting all files except excutable
echo "$(find . ! -name $EXEC_FILE -type f -delete)"

# executing file compiled with -fprofile-gen
myprint "${BLUE}executing $OUTDIR/$EXEC_FILE"
./$EXEC_FILE > exec.log
myprint "${GREEN}execution log saved to ${CYAN}$OUTDIR/exec.log"

# moving *.gcda files from $OBJDIR/objects to $OBJDIR/profile
clean_dir ../../$OBJDIR/profile
mv ../../$OBJDIR/objects/*.gcda ../../$OBJDIR/profile/
myprint "${GREEN}$(ls ../../$OBJDIR/profile | wc -l) *.gcda profiling files have written to $OBJDIR/profile"

cd ../..
