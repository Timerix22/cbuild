# v5
+ added task clean
+ added task exec_dbg
+ added task build_profile
+ added -flto optimization to build_exec task
+ added -fprofile-use to build_exec task
+ removed default configs loading in `init.sh`, now reads just line with version from `cbuild/default.config` and `default.config` 
+ OBJDIR structure changed
+ added error on unknown task in config
+ makefile now writes logs to make_raw.log
+ added makefile task fix_log
+ new comments in scripts and Makefile 
+ wrapped arguments with quots in scripts
