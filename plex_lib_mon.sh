#!/bin/bash

# Check if inotify-tools is installed. If not, install it
if ! [ -x "$(command -v inotifywait)" ]; then
    echo "$(date '+[%Y-%m-%d | %I:%M:%S %p]')  Plex Lib Monitor (BASH): inotify-tools is not installed. Installing..."
    sudo apt update
    sudo apt install -y inotify-tools
fi

# Check if path to watch directory is provided, if not then exit, else set watch_dir
if [ -z "$1" ]; then
    echo "$(date '+[%Y-%m-%d | %I:%M:%S %p]')  Plex Lib Monitor (BASH): Please provide path to watch directory"
    exit 1
else
    watch_dir="$1"
fi

# monitor watched directory recursively. Include file/dir names with empty spaces
inotifywait -r -m -e create --format '%w%f' "$watch_dir" |
while IFS= read -r filepath; do
    echo "$(date '+[%Y-%m-%d | %I:%M:%S %p]')  Plex Lib Monitor (BASH): SETFACL: $filepath"
    setfacl -m u:plex:rwx "$filepath"
    setfacl -m g:plex:rwx "$filepath"
done
