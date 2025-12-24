#!/usr/bin/env bash

target="$1"
tempfile=$(mktemp)
cp -L "$target" "$tempfile" || return
rm -rf "$target"
cp -a "$tempfile" "$target"
chmod --reference="$tempfile" "$target"
rm -rf "$tempfile"
