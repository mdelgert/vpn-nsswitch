#!/bin/bash
set -euo pipefail

if [[ "$EUID" -eq 0 ]]; then
  echo "🚫 Do not run this script as root. Use a regular user — it will call sudo when needed."
  exit 1
fi

echo "🧹 Purging vpn-nsswitch..."
sudo apt purge -y vpn-nsswitch || true

echo "🧹 Autoremoving unused dependencies..."
sudo apt-get autoremove -y || true

echo "🧹 Cleaning up package cache..."
sudo apt-get clean || true

echo "✅ vpn-nsswitch uninstalled successfully."
exit 0
