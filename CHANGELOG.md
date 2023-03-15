# v6
+ `build_profile` task was split to `profile` and `gprof`
+ added task `sanitize`

# v5
+ added task `clean`
+ added task `exec_dbg`
+ added task `build_profile`
+ added `-flto` optimization to `build_exec` task
+ added `-fprofile-use` to `build_exec` task
+ removed default configs loading in `init.sh`, now reads just line with version from `cbuild/default.config` and `default.config` 
+ `OBJDIR` structure changed
+ added error on unknown task in config
+ makefile now writes logs to `make_raw.log`
+ added makefile task `fix_log`
+ new comments in scripts and Makefile 
+ wrapped arguments with quots in scripts
+ now you have to add `CPP_ARGS` to `LINKER_ARGS` manually
+ added `error(msg)` function to `functions.sh`
+ replaced `printf` calls with `myprint` in scripts
+ added default `.gitignore`
+ added *.log to `.gitignore`
