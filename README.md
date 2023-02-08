# cbuild
My C/C++ build system written in bash.

Repo contains some functions, which can be used in your custom task scripts. There are also some default tasks.

All tasks can be launched through `Makefile` or `cbuild/call_task.sh`. Tasks can be configured in `current.config`.

## How to set up
```bash
git clone http://github.com/Timerix22/cbuild.git && \
cbuild/setup.sh submodule
```
Than create your project `default.config` based on `cbuild/default.config`.
