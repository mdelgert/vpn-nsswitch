#!/bin/bash

# This script builds the package using debuild and moves all build artifacts to ./build-artifacts
# Location: tools/build.sh
# Usage: ./tools/build.sh

set -e

# Prevent running as root/sudo
if [ "$EUID" -eq 0 ]; then
  echo "Do not run this script as root or with sudo."
  exit 1
fi

cd ../
sudo chown -R $(id -u):$(id -g) ../
debuild -us -uc
rm -rf build-artifacts
mkdir -p build-artifacts
mv ../vpn-nsswitch_* build-artifacts/
mv ../vpn-nsswitch-* build-artifacts/
lintian build-artifacts/*.deb

exit 0