#!/bin/bash

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

# This script builds the package using debuild and moves all build artifacts to ./build-artifacts

# Check if script is run as root (sudo)
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)." >&2
    exit 1
fi

# Clean up previous artifacts
rm -rf build-artifacts
mkdir -p build-artifacts

# Remove old artifacts from parent dir
PARENT_DIR="$(dirname "$PROJECT_ROOT")"
delete_patterns=("*.deb" "*.ddeb" "*.changes" "*.build" "*.buildinfo" "*.dsc" "*.tar.*")
for pattern in "${delete_patterns[@]}"; do
    rm -f "$PARENT_DIR"/$pattern
done

# Build the package
cd "$PROJECT_ROOT"
dpkg-buildpackage -us -uc -b

# Move new artifacts from parent dir to build-artifacts/
shopt -s nullglob
for pattern in "${delete_patterns[@]}"; do
    for file in "$PARENT_DIR"/$pattern; do
        [ -e "$file" ] && mv "$file" build-artifacts/
    done
done
shopt -u nullglob