#!/bin/bash

# Part 1: File and Directory Exploration


# Display a welcome message and list all files and directories in the current path

echo "Welcome to the 2nd day of bash scripting challenge"

echo "Files and Directories are in present working directory"

ls -lh

# Loop to continuously display the file and directory list until the user decides to exit

 while true; do
        echo "Current Files and Directories:"
        ls -lh

        read -p "Press 'q' to quit or any other key to refresh the list: " input
        if [ "$input" = "q" ]; then
            break
        fi
    done

# Part 2: Character Counting
# Count the characters in the user's input line

 echo "Part 2: Character Counting"
    echo "Enter lines of text (press Enter without any text to exit):"
    while true; do
        read line
        if [ -z "$line" ]; then
            break
        fi

        char_count=${#line}
        echo "Character count for '$line': $char_count"
    done