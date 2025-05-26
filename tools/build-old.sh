#!/bin/bash

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

# This script builds the package using debuild and moves all build artifacts to ./build-artifacts

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
# dpkg-buildpackage -us -uc -b
dpkg-buildpackage -us -uc

# List the contents of the parent directory
ls -l

# Move new artifacts from parent dir to build-artifacts/
shopt -s nullglob
for pattern in "${delete_patterns[@]}"; do
    for file in "$PARENT_DIR"/$pattern; do
        [ -e "$file" ] && mv "$file" build-artifacts/
    done
done
shopt -u nullglob

# Check with lintian
if command -v lintian &> /dev/null; then
    echo "Running lintian on the built package..."
    lintian build-artifacts/*.deb
else
    echo "Lintian is not installed. Skipping lintian check."
fi
echo "Build artifacts are located in: $PROJECT_ROOT/build-artifacts"
echo "Build completed successfully."

# List the contents of the build-artifacts directory
ls -l build-artifacts