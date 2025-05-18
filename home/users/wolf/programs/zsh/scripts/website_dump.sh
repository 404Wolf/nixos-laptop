#!/usr/bin/env bash

url="$1"
output_file="${2:-website.html}"

if [[ -z "$url" ]]; then
    echo "dump_webpage <URL> [output_file]"
    return 1
fi

echo "Fetching and processing $url..."
chromium --headless --window-size=1920,1080 \
    --run-all-compositor-stages-before-draw \
    --virtual-time-budget=90000 \
    --incognito \
    --dump-dom "$url" | \
    monolith - -I -b "$url" -o "$output_file"

echo "Done! Saved to $output_file"
