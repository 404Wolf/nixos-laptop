# shellcheck shell=bash

nix build "$1" --keep-failed --impure && \
BUILD_DIR=$(grep "keeping build directory" /dev/stderr 2>&1 | tail -1 | cut -d "'" -f 2) && \
cd "$BUILD_DIR" && \
copy "$BUILD_DIR" . # to system clipboard
