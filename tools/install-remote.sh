#!/bin/bash

# Check if script is run as root (sudo)
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)." >&2
    exit 1
fi

cd ../
mkdir -p build-artifacts
cd build-artifacts
wget -O vpn-nsswitch.deb $(curl -s https://api.github.com/repos/mdelgert/vpn-nsswitch/releases/latest | grep "browser_download_url.*deb" | cut -d '"' -f 4)
dpkg -i vpn-nsswitch.deb
apt-get install -f