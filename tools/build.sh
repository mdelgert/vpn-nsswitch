#!/bin/bash

# This script builds the package using debuild and moves all build artifacts to ./build-artifacts

set -e

ls -l
cd ../
debuild -us -uc
rm -rf build-artifacts
mkdir -p build-artifacts
mv ../vpn-nsswitch* build-artifacts/
ls -l build-artifacts
lintian build-artifacts/*.deb

exit 0