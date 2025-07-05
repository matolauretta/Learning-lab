#!/bin/sh

# This script finds the 10 largest files in a given directory, skipping default system folders.

if [ -z "$1" ]; then
    echo "Error: No directory specified."
    echo "Usage: $0 /path/to/directory"
    exit 1
fi

TARGET_DIR="$1"

# Define system folders to skip for each OS
SKIP_DIRS=()

case "$(uname)" in
    Darwin)
        SKIP_DIRS=("/System" "/Library" "/private" "/Volumes" "/dev" "/Network" "/cores" "/usr" "/bin" "/sbin")
        ;;
    Linux)
        SKIP_DIRS=("/proc" "/sys" "/dev" "/run" "/tmp" "/var/run" "/var/lock" "/snap" "/usr" "/bin" "/sbin" "/lib" "/lib64")
        ;;
    CYGWIN*|MINGW*|MSYS*)
        SKIP_DIRS=("/Windows" "/Program Files" "/Program Files (x86)" "/ProgramData" "/Users/All Users" "/Users/Default" "/Users/Default User" "/Users/Public" "/$Recycle.Bin" "/System Volume Information")
        ;;
esac

# Build find prune expression
PRUNE_EXPR=""
for dir in "${SKIP_DIRS[@]}"; do
    PRUNE_EXPR="$PRUNE_EXPR -path \"$dir\" -prune -o"
done

# Run find in a safe and portable way
find "$TARGET_DIR" $(for dir in "${SKIP_DIRS[@]}"; do echo "-path \"$dir\" -prune -o"; done) -type f -print | \
while IFS= read -r file; do
    du -h "$file"
done 2>/dev/null | sort -rh | head -n 10