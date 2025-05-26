#!/bin/bash

sudo apt-get remove vpn-nsswitch -y
sudo apt-get purge vpn-nsswitch -y
sudo apt-get autoremove -y
sudo apt-get clean -y