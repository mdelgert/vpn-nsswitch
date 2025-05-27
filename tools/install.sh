#!/bin/bash
set -e

# Clean previous install if it exists
sudo apt purge -y vpn-nsswitch || true

# Download latest release .deb
wget -O vpn-nsswitch.deb $(curl -s https://api.github.com/repos/mdelgert/vpn-nsswitch/releases/latest \
  | grep "browser_download_url.*\.deb" \
  | cut -d '"' -f 4)

# Install .deb
sudo dpkg -i vpn-nsswitch.deb

# Fix missing dependencies
sudo apt-get install -f -y

exit 0
