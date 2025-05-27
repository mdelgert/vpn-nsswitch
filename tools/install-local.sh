#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Do not run as root"
  exit 1
fi

cd ../

cd build-artifacts

if dpkg -l | grep -q '^ii  vpn-nsswitch '; then
  sudo apt purge vpn-nsswitch -y
fi

sudo dpkg -i *.deb

# Show installed files
dpkg -L vpn-nsswitch

exit 0