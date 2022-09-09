#!/bin/bash

source cbuild/init.sh

print "${CYAN}==========[build_static_lib]==========\n"
clear_dir "$OUTDIR"
clear_dir "$OBJDIR"
compile_c "$BUILD_STATIC_LIB_C_ARGS" "$SRC_C"
compile_cpp "$BUILD_STATIC_LIB_CPP_ARGS" "$SRC_CPP"
pack_static_lib "$STATIC_LIB_FILE" 
