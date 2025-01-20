#!/bin/bash

watch_dir="./testDir"

inotifywait -r -m -e create "$watch_dir" | while read event; do
	filename=$(echo "$event" | cut -d ' ' -f 3-) # -f 3- means fields from 3 to the end
	filepath="$watch_dir/$filename"
	echo "$(date '+[%Y-%m-%d | %I:%M:%S %p]')  SETFACL: $filepath"
	setfacl -m u:plex:rwx "$filepath"
	setfacl -m g:plex:rwx "$filepath"
done