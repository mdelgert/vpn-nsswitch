#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Do not run as root"
  exit 1
fi

sudo apt-get remove vpn-nsswitch -y
sudo apt-get purge vpn-nsswitch -y
sudo apt-get autoremove -y
sudo apt-get clean -y

exit 0