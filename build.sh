#!/bin/bash

dpkg-deb --build --root-owner-group .
sudo apt install ./nsswitch-vpn_1.0.0.deb
nmcli connection up WireGuard
ssh b1.local
nmcli connection down WireGuard
sudo apt remove nsswitch-vpn