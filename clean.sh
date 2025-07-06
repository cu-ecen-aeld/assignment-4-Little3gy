#!/bin/bash

# Ensure we are in the assignment-4-Little3gy directory
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR"

echo "Running make distclean in buildroot directory..."
cd buildroot
make distclean
echo "Buildroot distclean completed."

