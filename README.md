# cbuild
My C/C++ build system written in bash.

Repo contains some scripts (functions, init, etc.), which can be used in your custom task scripts. There are also some default tasks.

All tasks should be launched through `Makefile`. Tasks can be configured in `current.config` file (it is automatically created by init.sh).

## How to set up

```bash
cd some_project
git clone http://github.com/Timerix22/cbuild.git
cp cbuild/default.Makefile Makefile
bash cbuild/chmod_scripts.sh
make
```

You can create your own default config. Put it in project directory and name default.config
