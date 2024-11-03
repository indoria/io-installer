#!/bin/bash

# Function to check if required tools are installed
check_tools() {
  echo "Checking required tools..."
  for tool in git jq; do
    command -v $tool >/dev/null 2>&1 || { echo >&2 "$tool is required but not installed. Aborting."; exit 1; }
  done
}

# Call the check function in your install script
check_tools
