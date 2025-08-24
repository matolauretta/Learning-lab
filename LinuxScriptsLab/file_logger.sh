#!/bin/bash
#FUNCTIONS
# Función para loguear con timestamp
log_info() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] $1" | tee -a "$LOG_FILE"
}

log_warn() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [WARN] $1" | tee -a "$LOG_FILE"
}

log_error() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" | tee -a "$LOG_FILE" >&2
}

# Directorio del log (modificable)
LOG_FILE="/tmp/myscript.log"
LOG_DIR=$(dirname "$LOG_FILE")
# check if at least two arguments are provided
if [ $# -lt 2 ]; then
    echo "usage: $0 followed by the path to a directory and one or more files"
    echo "Usage: $0 /path/to/directory <file1> [<file2> ...]"
    exit 1
fi
#check if log directory and file exists
if [ ! -d "$LOG_DIR" ]; then
    log_warn "WARN: Log directory '$LOG_DIR' does not exist."
    log_info "Creating log directory '$LOG_DIR'."
    mkdir -p "$LOG_DIR"
    if [ $? -ne 0 ]; then
        log_error "Error: Could not create log directory '$LOG_DIR'."
        exit 1
    else
        log_info "Log directory '$LOG_DIR' created successfully."
    fi
fi

if [ ! -f "$LOG_FILE" ]; then
    log_warn "WARN: File '$LOG_FILE' does not exist in $LOG_DIR."
    log_info "Creating log file '$LOG_FILE'."
    touch "$LOG_FILE"
    if [ $? -ne 0 ]; then
        log_error "Error: Could not create log file '$LOG_FILE'."
        exit 1 
    else
        log_info "Log file '$LOG_FILE' created successfully in $LOG_DIR."
    fi
fi
TARGET_DIR="$1"
if [ ! -d "$TARGET_DIR" ]; then
    log_error "$TARGET_DIR is not a directory."
    exit 1
fi

shift

while [ $# -gt 0 ]; do
    filename=$1
    if [ ! -f "$TARGET_DIR/$filename" ]; then
        log_error "Error: File '$filename' does not exist in $TARGET_DIR."
    else
        log_info "File '$filename' exists in $TARGET_DIR."
        #file_size=$(stat -c%s "$filename")
        lines=$(wc -l "$TARGET_DIR/$filename")
        log_info "File: $filename exists and has: $lines lines"
    fi
    shift
done