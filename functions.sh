#!/bin/bash

function clear_dir {
	myprintf "${BLUE}clearing $1\n"
    rm -rf $1
	mkdir $1
}

function compile {
    local cmp=$1
    myprintf "${BLUE}compiler: ${GRAY}$cmp\n"
    local std=$2
    myprintf "${BLUE}standard: ${GRAY}$std\n"
    local warn=$3
    myprintf "${BLUE}warnings: ${GRAY}$warn\n"
    local args=$4
    myprintf "${BLUE}args: ${GRAY}$args\n"
    local sources=$5
    myprintf "${BLUE}sources: ${GRAY}$sources\n"
    local compilation_error=0

	for srcfile in $sources
    do (
        local object="$OBJDIR/$(basename $srcfile).o"
        if ! $($cmp -std=$std $warn $args -c -o $object $srcfile) 
        then
            myprintf "${RED}some error happened\n"
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
	myprintf "${CYAN}-------------[compile_c]--------------\n"
    compile $CMP_C $STD_C "$WARN_C" "$1" "$2"
}

# (args, sources)
function compile_cpp {
	myprintf "${CYAN}------------[compile_cpp]-------------\n"
    compile $CMP_CPP $STD_CPP "$WARN_CPP" "$1" "$2"
}

# (args, outfile)
function link {
	myprintf "${CYAN}----------------[link]----------------\n"
    local args=$1
    myprintf "${BLUE}args: ${GRAY}$args\n"
    local outfile=$OUTDIR/$2
    myprintf "${BLUE}outfile: ${GRAY}$outfile\n"
    local objects="$(find $OBJDIR -name '*.o')
$(find $OBJDIR -name '*.a')"
    myprintf "${BLUE}objects: ${GRAY}$objects\n"
    if $CMP_CPP $args -o $outfile $(echo $objects | tr '\n' ' ')
    then 
        myprintf "${GREEN}file $CYAN$outfile ${GREEN}created\n"
        rm -rf $OBJDIR
    else
        myprintf "${RED}some error happened\n"
        exit 1
    fi
}

# (outfile)
function pack_static_lib {
	myprintf "${CYAN}----------------[link]----------------\n"
    local outfile=$OUTDIR/$1
    myprintf "${BLUE}outfile: ${GRAY}$outfile\n"
    local objects="$(find $OBJDIR -name *.o)"
    myprintf "${BLUE}objects: ${GRAY}$objects\n"
    if ar rcs $outfile $(echo $objects | tr '\n' ' ')
    then 
        myprintf "${GREEN}file $CYAN$outfile ${GREEN}created\n"
        rm -rf $OBJDIR
    else
        myprintf "${RED}some error happened\n"
        exit 1
    fi
}
