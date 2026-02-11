#!/bin/bash

# 1. Check if a directory path was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# The script will use "testdir" if you pass it as an argument
TARGET_DIR=$1
BACKUP_DIR="$TARGET_DIR/backup"

# 2. Validate the directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 1
fi

# 3. Create the backup subdirectory inside testdir
mkdir -p "$BACKUP_DIR"

echo "Starting background move operations from $TARGET_DIR to $BACKUP_DIR..."
echo "Parent Script PID: $$"

# 4. Loop through each file in testdir
for file in "$TARGET_DIR"/*; do
    # Skip if it is the backup directory itself
    if [ -d "$file" ]; then continue; fi

    # Move file to backup/ in the background (&)
    mv "$file" "$BACKUP_DIR/" &
    
    # Capture the PID of the background process ($!)
    echo "Moving $(basename "$file") - Process ID: $!"
done

# 5. Wait for all background moves to finish
wait
echo "All background move operations completed."
