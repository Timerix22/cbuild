#!/bin/bash

tabs 4

# exit on errors
set -eo pipefail

source cbuild/colors.sh
source cbuild/functions.sh
source cbuild/detect_os.sh


# copying default config from cbuild if it not exists
if [ ! -f default.config ]; then
    cp cbuild/default.config default.config
    myprint "${YELLOW}Default config didn't exist, copied from cbuild."
fi

function exec_script_line {
    local script="$1"
    local line_num="$2"
    myprint "${BLUE}reading line $line_num from $script"
    local line_str="$(sed $line_num'!d' $script)"
    myprint "$line_str"
    eval "$line_str"
}

# getting version of cbuild installation
exec_script_line cbuild/default.config 2
INSTALLED_CBUILD_VERSION="$CBUILD_VERSION"
unset CBUILD_VERSION

# getting version of default config
exec_script_line default.config 3
DEFAULT_CONFIG_VERSION="$CONFIG_VERSION"
unset CONFIG_VERSION

# undefined task
[ -z "$TASK" ] && TASK="no_task"

# error on undefined
set -u

# reading current config or creating default
if [ ! -f current.config ]; then
    myprint "${YELLOW}./current.config doesn't exist"
    cp default.config current.config
    myprint "${YELLOW}New config created from the default.\nEdit it."
    exit
fi

myprint "${BLUE}reading ./current.config"
source current.config

myprint "${WHITE}project: ${CYAN}$PROJECT"

myprint "${WHITE}current.config cbuild version: ${CYAN}$CBUILD_VERSION"
myprint "${WHITE}installed cbuild version: ${CYAN}$INSTALLED_CBUILD_VERSION"
myprint "${WHITE}current.config version: ${CYAN}$CONFIG_VERSION"
myprint "${WHITE}default.config version: ${CYAN}$DEFAULT_CONFIG_VERSION"

# checking versions
if [ ! "$CBUILD_VERSION" -eq "$INSTALLED_CBUILD_VERSION" ]; then
    error "config was created for outdated cbuild version"
fi
if [ ! "$CONFIG_VERSION" -eq "$DEFAULT_CONFIG_VERSION" ]; then
    error "config version isn't correct"
fi

mkdir -p "$OUTDIR"
mkdir -p "$OBJDIR/libs"
mkdir -p "$OBJDIR/objects"
mkdir -p "$OBJDIR/profile"

# dont thorw error on undefined variable
set +u

myprint "${GREEN}cbuild initialized!"
