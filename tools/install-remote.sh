#!/bin/bash

cd ../
mkdir -p build-artifacts
cd build-artifacts
wget -O vpn-nsswitch.deb $(curl -s https://api.github.com/repos/mdelgert/vpn-nsswitch/releases/latest | grep "browser_download_url.*deb" | cut -d '"' -f 4)
sudo dpkg -i vpn-nsswitch.deb
sudo apt-get install -f