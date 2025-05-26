#!/bin/bash

# Check if script is run as root (sudo)
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)." >&2
    exit 1
fi

cd ../

cd build-artifacts

sudo dpkg -i nsswitch-vpn_1.0.0_amd64.deb