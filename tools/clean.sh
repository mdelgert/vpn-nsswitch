#!/bin/bash

# Check if script is run as root (sudo)
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)." >&2
    exit 1
fi

cd ../

# Remove the debian package
rm vpn-nsswitch
rm -rf build-artifacts/
rm -rf debian/.debhelper/
rm -rf debian/debhelper*
rm -rf debian/nsswitch-vpn*
rm -rf debian/vpn-nsswitch/
rm -rf debian/files

# Remove installed files
# rm -f /var/log/nsswitch_script.log
# rm -rf /etc/nsswitch.d
# rm /usr/bin/nsswitch_up.sh
# rm /usr/bin/nsswitch_down.sh
# rm /etc/NetworkManager/dispatcher.d/vpn-nsswitch-openvpn.sh
# rm /etc/NetworkManager/dispatcher.d/vpn-nsswitch-wireguard.sh