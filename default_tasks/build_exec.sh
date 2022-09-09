#!/bin/bash

compile_c "$C_ARGS" "$SRC_C $TESTS_C"
compile_cpp "$CPP_ARGS" "$SRC_CPP $TESTS_CPP"
link "$CPP_ARGS $LINKER_ARGS" "$EXEC_FILE"
