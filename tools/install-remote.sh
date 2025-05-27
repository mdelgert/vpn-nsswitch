#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Do not run as root"
  exit 1
fi

cd ../
mkdir -p build-artifacts
cd build-artifacts
wget -O vpn-nsswitch.deb $(curl -s https://api.github.com/repos/mdelgert/vpn-nsswitch/releases/latest | grep "browser_download_url.*deb" | cut -d '"' -f 4)
dpkg -i vpn-nsswitch.deb
apt-get install -f

exit 0