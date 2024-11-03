#!/bin/bash

# Load JSON parser (jq is a common JSON parsing tool for bash)
# Make sure jq is installed
command -v jq >/dev/null 2>&1 || { echo >&2 "jq is required but not installed. Aborting."; exit 1; }

# Function to clone repositories based on role
clone_repositories() {
  role=$1
  echo "Installing setup for role: $role"

  # Read the role configuration from the JSON file
  REPOS=$(jq -r --arg role "$role" '.[$role].repositories[]' config/roles.json)

  if [ -z "$REPOS" ]; then
    echo "Invalid role or no repositories configured for this role."
    exit 1
  fi

  # Clone each repository
  for REPO in $REPOS; do
    echo "Cloning repository: $REPO"
    git clone "$REPO" || { echo "Failed to clone repository: $REPO"; exit 1; }
  done

  echo "Installation complete for role: $role"
}

# Main installation flow
if [ $# -eq 0 ]; then
  echo "No role specified. Usage: ./install.sh <role>"
  exit 1
fi

ROLE=$1
clone_repositories $ROLE