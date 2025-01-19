#!/bin/bash

# function to create files and directories
create_dir_and_files() {
    mkdir testDir
    mkdir testDir/A
    mkdir testDir/B
    mkdir testDir/C
    echo "Hello World" > testDir/A/a.txt
    echo "Hello World" > testDir/B/b.txt
    echo "Hello World" > testDir/C/c.txt
}

# run python test
python plex_lib_mon.py &
PID=$!
echo "PID: $PID python test started"
sleep 1
create_dir_and_files
sleep 1
kill $PID
echo "PID: $PID python test killed"

# delete files and directories
rm -rf testDir/*

# run bash test
bash plex_lib_mon.sh &
PID=$!
echo "PID: $PID bash test started"
sleep 1
create_dir_and_files
sleep 1
kill $PID
echo "PID: $PID bash test killed"

# delete files and directories
rm -rf testDir/*
