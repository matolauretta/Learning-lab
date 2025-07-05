#!/bin/bash

if [ $# -lt 1 ]; then
    echo "usage: $0 followed by the path to search in and at least one filename to check"
    echo "Usage: $0 /path/to/directory <name1> [<name2> ...]"
    exit 1
fi

TARGET_DIR="$1"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: $TARGET_DIR is not a directory."
    exit 1
fi

echo "Checking files in directory: $TARGET_DIR"
shift  # Remove the first argument (directory path)

cd "$TARGET_DIR" || exit 1

while [ $# -gt 0 ]; do
    filename=$1
    if [ ! -f "$filename" ]; then
        echo "Error: File '$filename' does not exist in $TARGET_DIR."
    else
        echo "File '$filename' exists in $TARGET_DIR."
        #file_size=$(stat -c%s "$filename")
        wc -l "$filename" | awk '{print "File: " $2 " exists and has: " $1 lines}'
    fi
    shift
done
