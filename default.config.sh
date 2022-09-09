#!/bin/bash

PROJECT=some_project
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

OUTDIR=bin
OBJDIR=obj
EXEC_FILE=$PROJECT.com
SHARED_LIB_FILE=$PROJECT.so
STATIC_LIB_FILE=$PROJECT.a

PRE_BUILD_SCRIPT=tasks/pre_build.sh

case $TASK in
    build_exec)
        C_ARGS="-O2"
        CPP_ARGS="$C_ARGS"
        LINKER_ARGS=""
        TASK_SCRIPT="cbuild/build_exec.sh"
        ;;
    build_exec_dbg)
        C_ARGS="-O0 -g"
        CPP_ARGS="$C_ARGS"
        LINKER_ARGS=""
        TASK_SCRIPT="cbuild/build_exec.sh"
        ;;
    build_shared_lib)
        C_ARGS="-O2 -fpic -flto -shared"
        CPP_ARGS="$C_ARGS"
        LINKER_ARGS="-Wl,-soname,$SHARED_LIB_FILE"
        TASK_SCRIPT="cbuild/build_shared_lib.sh"
        ;;
    build_shared_lib_dbg
        C_ARGS="-O0 -g -fpic -shared"
        CPP_ARGS="$C_ARGS"
        LINKER_ARGS="-Wl,-soname,$SHARED_LIB_FILE"
        TASK_SCRIPT="cbuild/build_shared_lib.sh"
        ;;
    build_static_lib)
        C_ARGS="-O2 -fpic"
        CPP_ARGS="$C_ARGS" 
        TASK_SCRIPT="cbuild/build_static_lib.sh"
        ;;
    build_static_lib_dbg)
        C_ARGS="-O0 -g"
        CPP_ARGS="$C_ARGS" 
        TASK_SCRIPT="cbuild/build_static_lib.sh"
        ;;
    exec)
        TASK_SCRIPT="cbuild/exec.sh"
        ;;
    valgrind)  
        VALGRIND_ARGS="-s --log-file=valgrind.log --read-var-info=yes --track-origins=yes --fullpath-after=$PROJECT/ --leak-check=full --show-leak-kinds=all" 
        TASK_SCRIPT="cbuild/valgrind.sh"
        ;;
esac
