#!/bin/bash

# delete old objects
clean_dir "$OBJDIR/objects"

# copy profiling info
prof_files=$(find "$OBJDIR/profile/" -name '*.gcda')
if [ -z "$prof_files" ]; then
    myprint "${YELLOW}no profiling info found"
else
    myprint "${GREEN}profiling info found"
    for prof_file in $prof_files; do
        myprint "${GRAY}$(basename $prof_file)"
        cp $prof_file "$OBJDIR/objects/"
    done
fi

compile_c "$C_ARGS" "$SRC_C $TESTS_C"
compile_cpp "$CPP_ARGS" "$SRC_CPP $TESTS_CPP"
link "$LINKER_ARGS" "$EXEC_FILE"
