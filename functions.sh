#!/bin/bash

function myprint {
    printf "$@${GRAY}\n"
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
    local compilation_error=0

	for srcfile in $sources
    do (
        local object="$OBJDIR/objects/$(basename $srcfile).o"
        if ! $($cmp -std=$std $warn $args $include -c -o $object $srcfile)
        then
            error "some error happened"
            #TODO parallel variable assignement doesnt work in bash
            compilation_error=1
        fi
    ) & done
    wait

    #TODO doesnt work with multithreading
    if [ $compilation_error != 0 ]
    then
        exit -50
    fi
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

# (args, outfile)
function link {
	myprint "${CYAN}----------------[link]----------------"
    local args="$1"
    myprint "${BLUE}args: ${GRAY}$args"
    local outfile="$2"
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
