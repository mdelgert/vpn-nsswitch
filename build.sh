#!/bin/bash

# sudo apt update
# sudo apt install devscripts build-essential fakeroot

set -e

# Clean previous build artifacts
rm -f ../nsswitch-vpn_1.0.0.deb ../nsswitch-vpn_1.0.0_*.build ../nsswitch-vpn_1.0.0_*.changes ../nsswitch-vpn_1.0.0_*.tar.* ../nsswitch-vpn_1.0.0_*.dsc

# Remove installed package if present
# sudo apt remove nsswitch-vpn -y || true

# Build the Debian package using standard tools
DEB_BUILD_OPTIONS=noautodbgsym dpkg-buildpackage -us -uc

# Install the newly built package
sudo apt install ../nsswitch-vpn_1.0.0_all.deb