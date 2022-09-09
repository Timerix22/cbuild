#!/bin/bash

PROJECT=some_project
OUTDIR=bin
OBJDIR=obj
CMP_C=gcc
CMP_CPP=g++
STD_C=c11
STD_CPP=c++17
WARN_C="-Wall -Wno-discarded-qualifiers"
WARN_CPP="-Wall"
SRC_C="$(    find src -name '*.c')"
SRC_CPP="$(  find src -name '*.cpp')"
TESTS_C="$(  find tests -name '*.c')"
TESTS_CPP="$(find tests -name '*.cpp')"
VALGRIND_ARGS="-s --log-file=valgrind.log --read-var-info=yes --track-origins=yes --fullpath-after=$POJECT/ --leak-check=full --show-leak-kinds=all"

# build_exec
EXEC_FILE=$POJECT.com
BUILD_EXEC_C_ARGS="-O2"
BUILD_EXEC_CPP_ARGS="$BUILD_EXEC_C_ARGS"
BUILD_EXEC_LINKER_ARGS=""
# build_exec_dbg
BUILD_EXEC_DBG_C_ARGS="-O0 -g"
BUILD_EXEC_DBG_CPP_ARGS="$BUILD_EXEC_DBG_C_ARGS"
BUILD_EXEC_DBG_LINKER_ARGS=""

# build_shared_lib
SHARED_LIB_FILE=$POJECT.so
BUILD_SHARED_LIB_C_ARGS="-O2 -fpic -flto -shared"
BUILD_SHARED_LIB_CPP_ARGS="$BUILD_SHARED_LIB_C_ARGS"
BUILD_SHARED_LIB_LINKER_ARGS="-Wl,-soname,$SHARED_LIB_FILE"

# build_static_lib
STATIC_LIB_FILE=$POJECT.a
BUILD_STATIC_LIB_C_ARGS="-O2 -fpic"
BUILD_STATIC_LIB_CPP_ARGS="$BUILD_STATIC_LIB_C_ARGS"
# build_static_lib_dbg
BUILD_STATIC_LIB_DBG_C_ARGS="-O0 -g"
BUILD_STATIC_LIB_DBG_CPP_ARGS="$BUILD_STATIC_LIB_DBG_C_ARGS"
