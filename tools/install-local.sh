#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Do not run as root"
  exit 1
fi

cd ../

cd build-artifacts

# Clean previous install if it exists
sudo apt purge -y vpn-nsswitch || true

# Install package
sudo dpkg -i *.deb

# Confirm installation
dpkg -L vpn-nsswitch

exit 0