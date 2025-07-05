#!/bin/bash

# This script is used to check for files in a directory and report their existence and line count.
check_file () {
    local file=$1
    if [ -f "$file" ]; then
        echo "File '$file' exists in $TARGET_DIR."
        wc -l "$file" | awk '{print "File: " $2 " exists and has: " $1 lines}'
    else
        echo "Error: File '$file' does not exist in $TARGET_DIR."
    fi
}

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
cd "$TARGET_DIR" || exit 1
shift  # Remove the first argument (directory path)

while [ $# -gt 0 ]; do
    check_file "$1"
    shift
done
