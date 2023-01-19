#!/bin/bash
source cbuild/colors.sh
source cbuild/functions.sh
source cbuild/detect_os.sh
# exit on errors
set -eo pipefail

# copying default config from cbuild if it not exists
if [ ! -f default.config ]; then
    cp cbuild/default.config default.config
    printf "${YELLOW}Default config didn't exist, copied from cbuild.\n"
fi
printf "Reading ./default.config\n"
source default.config
# getting some values from default config
DEFAULT_CONFIG_VERSION=$CONFIG_VERSION
DEFAULT_CBUILD_VERSION=$CBUILD_VERSION
unset CONFIG_VERSION
unset CBUILD_VERSION

# error on undefined
set -u

# reading current config or creating default
if [ ! -f current.config ]; then
    printf "${YELLOW}./current.config doesn't exist\n"
    cp default.config current.config
    printf "${YELLOW}New config created from the default.\nEdit it.\n${GRAY}"
    exit
fi
printf "Reading ./current.config\n"
source current.config

# checking versions
if [ ! $CBUILD_VERSION -eq $DEFAULT_CBUILD_VERSION ]; then
    printf "${RED}config was created for outdated cbuild version\n${GRAY}"
    exit
fi
if [ ! $CONFIG_VERSION -eq $DEFAULT_CONFIG_VERSION ]; then
    printf "${RED}config version isn't correct\n${GRAY}"
    exit
fi

mkdir -p "$OUTDIR"
mkdir -p "$OBJDIR"

# dont thorw error on undefined variable
set +u
