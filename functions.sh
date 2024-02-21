#!/bin/bash

function myprint {
    # first gray is needed to print string trarting with -
    printf "${GRAY}$@${GRAY}\n"
}

function error {
    myprint "${RED}$1"
    exit 1
}

function clean_dir {
    local dir="$1"
	myprint "${WHITE}cleaning $dir"
    rm -rf "$dir"
    mkdir "$dir"
}

function delete_dir {
    local dir="$1"
	myprint "${WHITE}deleting $dir"
    rm -rf "$dir"
}

function try_delete_dir_or_file {
    local path="$1"
    if [ -f "$path" ] || [ -d "$path" ]; then
        rm -rf "$path"
        myprint "${WHITE}deleting $path"
    fi
}


function compile {
    local cmp="$1"
    myprint "${BLUE}compiler: ${GRAY}$cmp"
    local std="$2"
    myprint "${BLUE}standard: ${GRAY}$std"
    local warn="$3"
    myprint "${BLUE}warnings: ${GRAY}$warn"
    local args="$4"
    myprint "${BLUE}args: ${GRAY}$args"
    local include="$5"
    myprint "${BLUE}include dirs: ${GRAY}$include"
    local sources="$6"
    myprint "${BLUE}sources: ${GRAY}$sources"
	for srcfile in $sources
    do (
        local object="$OBJDIR/objects/$(basename $srcfile).o"
        if ! $($cmp -std=$std $warn $args $include -c -o $object $srcfile)
        then
            error "some error happened"
            # TODO stop all threads
        fi
    ) & done
    wait
}

# (args, sources)
function compile_c {
	myprint "${CYAN}-------------[compile_c]--------------"
    compile "$CMP_C" "$STD_C" "$WARN_C" "$1" "$INCLUDE" "$2"
}

# (args, sources)
function compile_cpp {
	myprint "${CYAN}------------[compile_cpp]-------------"
    compile "$CMP_CPP" "$STD_CPP" "$WARN_CPP" "$1" "$INCLUDE" "$2"
}

# (outfile)
function pack_static_lib {
	myprint "${CYAN}----------[pack_static_lib]-----------"
    local outfile="$1"
    myprint "${BLUE}outfile: ${GRAY}$outfile"
    local objects="$(find $OBJDIR/objects -name *.o)
$(find $OBJDIR/libs -name '*.a')"
    myprint "${BLUE}objects: ${GRAY}$objects"
    if ar rcs "$OUTDIR/$outfile" $(echo "$objects" | tr '\n' ' ')
    then
        myprint "${GREEN}file $CYAN$outfile ${GREEN}created"
    else
        error "some error happened"
    fi
}


# if $lib_file doesn't exist or rebuild_* task was executed, builds static lib
function handle_static_dependency {
    local deps_basedir="${1%/}"
    local lib_project_dir="$2"
    local lib_build_task="$3"
    local lib_build_dir="$4"
    local lib_file="$5"
    if [ ! -f "$OBJDIR/libs/$lib_file" ] || [ -f .rebuild_$lib_file.tmp ]; then
        [[ -z "$lib_build_task" ]] && error "lib_build_task is empty" 
        myprint "${BLUE}making $lib_file by task $lib_build_task"

        local proj_root_dir="$(pwd)"
        cd "$deps_basedir/$lib_project_dir"
        if ! make "$lib_build_task"; then
            exit 1
        fi
        cd "$proj_root_dir"

        cp "$deps_basedir/$lib_project_dir/$lib_build_dir/$lib_file" "$OBJDIR/libs/"
        myprint "${GREEN}copied ${CYAN}$lib_file to $OBJDIR/libs/"
        rm -f .rebuild_$lib_file.tmp
    fi
}

function resolve_dependencies {
    deps_basedir=$1
    deps=$2
    [[ -z "$deps_basedir" ]] && deps_basedir="."
    OLDIFS="$IFS"
    IFS=$'\n'
    # Evalueting dependency expressions.
    # Necessary for overriding dependency configurations.
    for dep in $deps; do
        eval $dep
    done
    # handling dependencies
    for dep in $deps; do
        IFS="$OLDIFS"
        dep_dir=$(echo ${dep/=*/} | tr -d '[:blank:]')
        eval 'dep_params=$'$dep_dir
        f_args="$deps_basedir $dep_dir $dep_params"
        myprint "${BLUE}resolving dependency ${WHITE}$dep_dir${BLUE}: ${GRAY}$f_args"
        handle_static_dependency $f_args
        IFS=$'\n'
    done
    IFS="$OLDIFS"
}

function link {
	myprint "${CYAN}----------------[link]----------------"
    local args="$1"
    local outfile="$2"
    resolve_dependencies "$DEPS_BASEDIR" "$DEPS"
    myprint "${BLUE}args: ${GRAY}$args"
    myprint "${BLUE}outfile: ${GRAY}$outfile"
    local objects="$(find $OBJDIR/objects -name '*.o')
$(find $OBJDIR/libs -name '*.a')"
    myprint "${BLUE}objects: ${GRAY}$objects"
    local command="$CMP_CPP  $(echo "$objects" | tr '\n' ' ') $args -o $OUTDIR/$outfile"
    myprint "$command"
    if $command
    then
        myprint "${GREEN}file $CYAN$outfile ${GREEN}created"
    else
        error "some error happened"
    fi
}
