#!/bin/bash

source cbuild/init.sh

print "${CYAN}=============[build_exec]=============\n"
clear_dir "$OUTDIR"
clear_dir "$OBJDIR"
compile_c "$BUILD_EXEC_C_ARGS" "$SRC_C $TESTS_C"
compile_cpp "$BUILD_EXEC_CPP_ARGS" "$SRC_CPP $TESTS_CPP"
link "$BUILD_EXEC_CPP_ARGS $BUILD_EXEC_LINKER_ARGS" "$EXEC_FILE"
