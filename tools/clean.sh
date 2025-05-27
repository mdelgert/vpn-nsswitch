#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Do not run as root"
  exit 1
fi

cd ../
sudo rm -f vpn-nsswitch 2>/dev/null
sudo rm -rf build-artifacts/ 2>/dev/null
sudo rm -rf debian/.debhelper/ 2>/dev/null
sudo rm -rf debian/debhelper* 2>/dev/null
sudo rm -rf debian/vpn-nsswitch/ 2>/dev/null
sudo rm -rf debian/vpn-nsswitch.substvars 2>/dev/null
sudo rm -rf debian/files 2>/dev/null

exit 0