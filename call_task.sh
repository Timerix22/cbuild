#!/bin/bash

function exec_script {
    myprint "${BLUE}executing $1"
    source "$1"
}

function try_exec_script {
    if [ -f "$1" ]; then
        exec_script "$1"
    fi
}

function call_task {
    TASK="$1"
    source cbuild/init.sh
    myprint "${CYAN}===========[$TASK]==========="
    myprint "${WHITE}project: ${CYAN}$PROJECT"
    try_exec_script "$PRE_TASK_SCRIPT"
    exec_script "$TASK_SCRIPT"
    try_exec_script "$POST_TASK_SCRIPT"
}

time call_task "$1"
