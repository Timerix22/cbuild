#!/bin/bash

compile_c "$C_ARGS" "$SRC_C"
compile_cpp "$CPP_ARGS" "$SRC_CPP"
link "$CPP_ARGS" "$SHARED_LIB_FILE"
