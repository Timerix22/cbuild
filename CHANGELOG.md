# v7
+ added function `resolve_dependencies` to `link`
+ added variables `DEPS_BASEDIR` and `DEPS` to config
+ added script `rebuild_dep.sh` which can be called through `Makefile`
+ added dependency cleaning in `default_tasks/clean.sh`
+ added task `callgrind`
+ added task `no_task` which is been set in `init.sh` when `TASK` is empty
+ now `STATIC_LIB_FILE` starts with "lib"

# v6
+ `build_profile` task was split to `profile` and `gprof`
+ added task `sanitize`
+ default C++ standard set to `c++11`
+ added `INCLUDE` to `default.config`
+ moved `LINKER_ARGS` to the end of linkage command in `functions.sh` to properly link static libs
+ added function `try_delete_dir_or_file` for `clean` task
+ dead code removal in `build_exec` and `build_static_lib`

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
