#!/bin/bash

source cbuild/init.sh

print "${CYAN}========[build_shared_lib_dbg]========\n"
compile_c "$BUILD_SHARED_LIB_DBG_C_ARGS" "$SRC_C"
compile_cpp "$BUILD_SHARED_LIB_DBG_CPP_ARGS" "$SRC_CPP"
link "$BUILD_SHARED_LIB_DBG_CPP_ARGS $BUILD_SHARED_LIB_DBG_LINKER_ARGS" "$SHARED_LIB_FILE"
