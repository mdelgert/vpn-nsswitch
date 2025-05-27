#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Do not run as root"
  exit 1
fi

# Clean previous install if it exists
sudo apt purge -y vpn-nsswitch || true
sudo apt-get autoremove -y || true
sudo apt-get clean -y || true
 
exit 0