#!/bin/bash

# Function to create files and directories
create_dir_and_files() {
    mkdir -p testDir/A
    mkdir -p testDir/B
    mkdir -p testDir/C
    echo "Hello World" > testDir/A/a.txt
    echo "Hello World" > testDir/B/b.txt
    echo "Hello World" > testDir/C/c.txt
}

# function to kill all sub processes created by this script
kill_sub_processes() {
    PARENT_PID=$1
    MSG=$2
    CHILD_PIDS=$(pgrep -P $PARENT_PID)
    for PID in $CHILD_PIDS; do
        kill $PID
        echo "Killed child PID: $PID"
    done
    # Kill the parent process
    kill $PARENT_PID
    echo "Killed parent PID: $PARENT_PID $MSG"
}

# Run Python test
python plex_lib_mon.py &
PARENT_PID=$!
echo "PARENT PID: $PARENT_PID python test started"
sleep 1
create_dir_and_files
sleep 1
kill_sub_processes $PARENT_PID "python test"

# Delete files and directories
rm -rf testDir/*

# Run Bash test
bash plex_lib_mon.sh &
PARENT_PID=$!
echo "PARENT PID: $PARENT_PID bash test started"
sleep 1
create_dir_and_files
sleep 1
kill_sub_processes $PARENT_PID "bash test"

# Delete files and directories
rm -rf testDir/*
