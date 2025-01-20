#!/bin/bash

# check if inotify-tools is installed. If not, install it
if ! [ -x "$(command -v inotifywait)" ]; then
	echo "$(date '+[%Y-%m-%d | %I:%M:%S %p]')  Plex Lib Monitor (BASH): inotify-tools is not installed. Installing..."
	sudo apt update
	sudo apt install -y inotify-tools
fi

# check if path to watch directory is provided, if not, exit, else assign it to watch_dir
if [ -z "$1" ]; then
	echo "$(date '+[%Y-%m-%d | %I:%M:%S %p]')  Plex Lib Monitor (BASH): Please provide path to watch directory"
	exit 1
else
	watch_dir="$1"
fi

inotifywait -r -m -e create "$watch_dir" | while read path action file; do
	filepath="${path}${file}"
	echo "$(date '+[%Y-%m-%d | %I:%M:%S %p]')  Plex Lib Monitor (BASH):  SETFACL: $filepath"
	setfacl -m u:plex:rwx "$filepath"
	setfacl -m g:plex:rwx "$filepath"
done
