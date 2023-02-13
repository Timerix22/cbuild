#!/usr/bin/bash

delete_dir "$OBJDIR"
delete_dir "$OUTDIR"
myprint "${WHITE}deleting build logs"
rm -rf *.log
