#!/bin/bash

# Check if script is run as root (sudo)
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)." >&2
    exit 1
fi

apt-get remove vpn-nsswitch -y
apt-get purge vpn-nsswitch -y
apt-get autoremove -y
apt-get clean -y