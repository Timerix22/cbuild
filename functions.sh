#!/bin/bash

function myprint {
    myprintf "$1$GRAY"
}

function clear_dir {
	myprint "${BLUE}clearing $1\n"
    rm -rf $1
	mkdir $1
}

function compile {
    local cmp=$1
    myprint "${BLUE}compiler: ${GRAY}$cmp\n"
    local std=$2
    myprint "${BLUE}standard: ${GRAY}$std\n"
    local warn=$3
    myprint "${BLUE}warnings: ${GRAY}$warn\n"
    local args=$4
    myprint "${BLUE}args: ${GRAY}$args\n"
    local sources=$5
    myprint "${BLUE}sources: ${GRAY}$sources\n"
    local compilation_error=0

	for srcfile in $sources
    do (
        local object="$OBJDIR/$(basename $srcfile).o"
        if ! $($cmp -std=$std $warn $args -c -o $object $srcfile) 
        then
            myprint "${RED}some error happened\n"
            compilation_error=1
        fi
    ) & done
    wait

    if [ $compilation_error != 0 ]
    then
        exit 1
    fi
}

# (args, sources)
function compile_c {
	myprint "${CYAN}-------------[compile_c]--------------\n"
    compile $CMP_C $STD_C "$WARN_C" "$1" "$2"
}

# (args, sources)
function compile_cpp {
	myprint "${CYAN}------------[compile_cpp]-------------\n"
    compile $CMP_CPP $STD_CPP "$WARN_CPP" "$1" "$2"
}

# (args, outfile)
function link {
	myprint "${CYAN}----------------[link]----------------\n"
    local args=$1
    myprint "${BLUE}args: ${GRAY}$args\n"
    local outfile=$OUTDIR/$2
    myprint "${BLUE}outfile: ${GRAY}$outfile\n"
    local objects="$(find $OBJDIR -name '*.o')
$(find $OBJDIR -name '*.a')"
    myprint "${BLUE}objects: ${GRAY}$objects\n"
    if $CMP_CPP $args -o $outfile $(echo $objects | tr '\n' ' ')
    then 
        myprint "${GREEN}file $CYAN$outfile ${GREEN}created\n"
        rm -rf $OBJDIR
    else
        myprint "${RED}some error happened\n"
        exit 1
    fi
}

# (outfile)
function pack_static_lib {
	myprint "${CYAN}----------------[link]----------------\n"
    local outfile=$OUTDIR/$1
    myprint "${BLUE}outfile: ${GRAY}$outfile\n"
    local objects="$(find $OBJDIR -name *.o)"
    myprint "${BLUE}objects: ${GRAY}$objects\n"
    if ar rcs $outfile $(echo $objects | tr '\n' ' ')
    then 
        myprint "${GREEN}file $CYAN$outfile ${GREEN}created\n"
        rm -rf $OBJDIR
    else
        myprint "${RED}some error happened\n"
        exit 1
    fi
}
