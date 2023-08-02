#!/bin/bash

# Check if the script is executed with the correct number of arguments
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Get the directory path from the command-line argument
directory_path=$1

# Create a timestamped backup folder inside the specified directory
backup_folder="$directory_path/backup_$(date +'%Y%m%d_%H%M%S')"
mkdir -p "$backup_folder"

# Copy all the files from the specified directory to the backup folder using rsync
rsync -a "$directory_path/" "$backup_folder/"

# Function to perform rotation and keep only the last 3 backups
perform_rotation() {
    # Get a list of all backup folders in the specified directory and sort them by modification time (oldest first)
    backup_folders=($(find "$directory_path" -maxdepth 1 -type d -name "backup_*" -printf "%T+ %p\n" | sort | cut -d' ' -f2))

    # Calculate the number of backup folders
    num_backup_folders=${#backup_folders[@]}

    # Check if there are more than 3 backup folders
    if [ $num_backup_folders -gt 3 ]; then
        # Determine the number of folders to be removed (older backups)
        num_folders_to_remove=$((num_backup_folders - 3))

        # Remove the oldest backup folders (perform rotation)
        for ((i=0; i<$num_folders_to_remove; i++)); do
            rm -r "${backup_folders[i]}"
        done
    fi
}

# Perform rotation to keep only the last 3 backups
perform_rotation

# Display a message indicating the backup is successful
echo "Backup completed successfully. New backup is stored in $backup_folder."
