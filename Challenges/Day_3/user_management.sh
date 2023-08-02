#!/bin/bash

# Function to display usage information and available options
usage() {
  echo "Usage: $0 [OPTIONS]"
  echo "Options:"
  echo "  -c, --create        Create a new user account"
  echo "  -d, --delete        Delete an existing user account"
  echo "  -r, --reset         Reset the password of an existing user account"
  echo "  -l, --list          List all user accounts on the system"
  echo "  -h, --help          Display this help and usage information"
  exit 1
}

# Function to check if the user exists
user_exists() {
  local username="$1"
  id "$username" &>/dev/null
}

# Function to create a new user account
create_user() {
  read -p "Enter the new username: " new_username
  if user_exists "$new_username"; then
    echo "Error: User '$new_username' already exists."
    exit 1
  fi

  read -sp "Enter the new password: " new_password
  echo

  # You can add additional logic here, like creating a home directory or specifying a shell.
  # For simplicity, we are not doing it in this basic implementation.

  # Use useradd with the -m flag to create a home directory for the new user
  useradd -m "$new_username"

  # Set the password for the new user using echo and chpasswd
  echo "$new_username:$new_password" | chpasswd

  echo "User '$new_username' created successfully."
}

# Function to delete an existing user account
delete_user() {
  read -p "Enter the username to delete: " username
  if ! user_exists "$username"; then
    echo "Error: User '$username' does not exist."
    exit 1
  fi

  # You may want to add additional checks to ensure you don't accidentally delete a critical account (e.g., root).

  userdel "$username"
  echo "User '$username' deleted successfully."
}

# Function to reset the password of an existing user account
reset_password() {
  read -p "Enter the username to reset password: " username
  if ! user_exists "$username"; then
    echo "Error: User '$username' does not exist."
    exit 1
  fi

  read -sp "Enter the new password: " new_password
  echo

  # You may want to add more password complexity checks here before setting the new password.

  echo "$username:$new_password" | chpasswd
  echo "Password for '$username' has been updated."
}

# Function to list all the user accounts on the system
list_users() {
  echo "User accounts on this system:"
  echo "---------------------------"
  awk -F: '{printf "Username: %-15s UID: %s\n", $1, $3}' /etc/passwd
}

# Main script logic
if [ $# -eq 0 ]; then
  usage
fi

case "$1" in
  -c|--create)
    create_user
    ;;
  -d|--delete)
    delete_user
    ;;
  -r|--reset)
    reset_password
    ;;
  -l|--list)
    list_users
    ;;
  -h|--help)
    usage
    ;;
  *)
    echo "Error: Invalid option selected."
    usage
    ;;
esac

exit 0
