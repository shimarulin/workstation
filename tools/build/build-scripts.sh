#!/usr/bin/env bash

echo "Start script building:"

DIST_PATH="tools/bin"

mkdir -p $DIST_PATH

argbash tools/src/install.m4 -o $DIST_PATH/install && echo "  - $DIST_PATH/install"
argbash tools/src/apply.m4 -o $DIST_PATH/apply && echo "  - $DIST_PATH/apply"
argbash tools/src/mkrole.m4 -o $DIST_PATH/mkrole && echo "  - $DIST_PATH/mkrole"
argbash tools/src/setvars.m4 -o $DIST_PATH/setvars && echo "  - $DIST_PATH/setvars"
argbash tools/src/update.m4 -o $DIST_PATH/update && echo "  - $DIST_PATH/update"

printf "\nDone\n"
