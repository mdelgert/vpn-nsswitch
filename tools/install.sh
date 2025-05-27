#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Do not run as root"
  exit 1
fi

# Clean previous install if it exists
sudo apt purge -y vpn-nsswitch || true

wget -O vpn-nsswitch.deb $(curl -s https://api.github.com/repos/mdelgert/vpn-nsswitch/releases/latest | grep "browser_download_url.*deb" | cut -d '"' -f 4)

sudo dpkg -i vpn-nsswitch.deb

sudo apt-get install -f

exit 0