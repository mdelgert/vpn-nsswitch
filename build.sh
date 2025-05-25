#!/bin/bash

rm nsswitch-vpn_1.0.0.deb
sudo apt remove nsswitch-vpn -y
dpkg-deb --build --root-owner-group . nsswitch-vpn_1.0.0.deb
chmod 644 nsswitch-vpn_1.0.0.deb
sudo apt install ./nsswitch-vpn_1.0.0.deb
# nmcli connection up WireGuard
# nmcli connection down WireGuard