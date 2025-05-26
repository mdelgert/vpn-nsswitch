#!/bin/bash

# This script builds the package using debuild and moves all build artifacts to ./build-artifacts

# Prevent running as root/sudo
if [ "$EUID" -eq 0 ]; then
  echo "Do not run this script as root or with sudo."
  exit 1
fi

set -e

ls -l
cd ../
debuild -us -uc
rm -rf build-artifacts
mkdir -p build-artifacts
ls -l ../
mv ../vpn-nsswitch_* build-artifacts/
mv ../vpn-nsswitch-* build-artifacts/
ls -l build-artifacts
# lintian build-artifacts/*.deb

exit 0