# shellcheck shell=bash

ORIGINAL_DIR="$(pwd)"
BUILD_RESULT="$(nix build "$1" --keep-failed 2>&1 | tee /dev/tty)"
BUILD_DIR="$(echo "$BUILD_RESULT" | grep -oP "keeping build directory '\K[^']+")"
"$SHELL" -c "cd $BUILD_DIR && $SHELL"
copy "$ORIGINAL_DIR"
