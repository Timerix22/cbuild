#!/bin/bash

# delete old objects
clean_dir "$OBJDIR/objects"
compile_c "$C_ARGS" "$SRC_C"
compile_cpp "$CPP_ARGS" "$SRC_CPP"
pack_static_lib "$STATIC_LIB_FILE" 
