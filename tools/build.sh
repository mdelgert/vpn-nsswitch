#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Do not run as root"
  exit 1
fi

cd ../
debuild -us -uc
mv ../vpn-nsswitch_* build-artifacts/
lintian build-artifacts/*.deb
