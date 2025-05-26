#!/bin/bash

# Check if script is run as root (sudo)
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)." >&2
    exit 1
fi

cd ../

rm vpn-nsswitch
rm -rf build-artifacts/
rm -rf debian/.debhelper/
rm -rf debian/debhelper*
rm -rf debian/nsswitch-vpn*
rm -rf debian/vpn-nsswitch/
rm -rf debian/files
