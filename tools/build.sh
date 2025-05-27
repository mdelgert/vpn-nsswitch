#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Do not run as root"
  exit 1
fi

./clean.sh
cd ../
debuild -us -uc
mkdir -p build-artifacts 2>/dev/null
mv ../vpn-nsswitch_* build-artifacts/
lintian build-artifacts/*.deb
