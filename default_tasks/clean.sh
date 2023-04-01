#!/usr/bin/bash

try_delete_dir_or_file "$OBJDIR"
try_delete_dir_or_file "$OUTDIR"
myprint "${WHITE}deleting build logs"
rm -rf *.log
