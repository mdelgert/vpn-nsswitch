#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Do not run as root"
  exit 1
fi

cd ../

cd build-artifacts

sudo dpkg -i vpn-nsswitch_1.0.0_amd64.deb

exit 0