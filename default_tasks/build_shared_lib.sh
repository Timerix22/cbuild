#!/bin/bash

source cbuild/init.sh

print "${CYAN}==========[build_shared_lib]==========\n"
clear_dir "$OUTDIR"
clear_dir "$OBJDIR"
compile_c "$BUILD_SHARED_LIB_C_ARGS" "$SRC_C"
compile_cpp "$BUILD_SHARED_LIB_CPP_ARGS" "$SRC_CPP"
link "$BUILD_SHARED_LIB_CPP_ARGS $BUILD_SHARED_LIB_LINKER_ARGS" "$SHARED_LIB_FILE"
