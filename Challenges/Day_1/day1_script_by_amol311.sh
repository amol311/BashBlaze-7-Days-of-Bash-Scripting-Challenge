#!/bin/bash

# Task 1: Comment in bash script

# The first line of the bash script is shebang. Which tells system that how to execute the command with shells like /bin/bash, /bin/sh, /bin/

# Task 2:  Echo statement.
echo "Hello World"

# Task 3: Define variables

var1="This is variable one"
var2="This is variable two"

# Task 4: Using Variables

var3="$var1 & $var2"

echo "This message is printed by 3rd variable. $var3"

# Task 5 : Using Built in variables

echo "My user name is $USER"
echo "My Home Directory is $HOME"
echo "This is the Present Working Directory $PWD"
echo "My hostname is $HOSTNAME"
echo "Bash version I am using - $BASH_VERSION"

# Task 6 : Use of wildcards

echo "Files with .sh extension in the current directory"

ls *.sh
