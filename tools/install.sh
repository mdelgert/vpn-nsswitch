#!/bin/bash
set -euo pipefail

# -----------------------------
# vpn-nsswitch installer script
# Get latest or specific version from GitHub
# curl -sSL https://raw.githubusercontent.com/mdelgert/vpn-nsswitch/main/tools/install.sh | bash
# curl -sSL https://raw.githubusercontent.com/mdelgert/vpn-nsswitch/main/tools/install.sh | bash -s -- --version v1.0.3
# -----------------------------

REPO="mdelgert/vpn-nsswitch"
PACKAGE="vpn-nsswitch"
TMP_DEB="vpn-nsswitch.deb"
VERSION=""
GITHUB_API="https://api.github.com/repos/$REPO/releases"

# --- Parse flags ---
while [[ $# -gt 0 ]]; do
  case "$1" in
    --version)
      VERSION="$2"
      shift 2
      ;;
    *)
      echo "Usage: $0 [--version <version>]"
      exit 1
      ;;
  esac
done

# --- Determine URL ---
if [[ -n "$VERSION" ]]; then
  echo "🔍 Looking for version: $VERSION"
  DOWNLOAD_URL=$(curl -s "$GITHUB_API/tags/$VERSION" \
    | grep "browser_download_url.*\.deb" \
    | cut -d '"' -f 4)
else
  echo "🔍 Fetching latest release..."
  DOWNLOAD_URL=$(curl -s "$GITHUB_API/latest" \
    | grep "browser_download_url.*\.deb" \
    | cut -d '"' -f 4)
fi

if [[ -z "$DOWNLOAD_URL" ]]; then
  echo "❌ Failed to find a .deb release for $PACKAGE"
  exit 1
fi

echo "📦 Downloading: $DOWNLOAD_URL"
wget -q -O "$TMP_DEB" "$DOWNLOAD_URL"

# --- Uninstall existing package ---
echo "🧹 Removing existing $PACKAGE if installed..."
sudo apt purge -y "$PACKAGE" || true

# --- Install new package ---
echo "📥 Installing $TMP_DEB..."
sudo dpkg -i "$TMP_DEB" || true

# --- Fix missing dependencies ---
echo "🔧 Resolving dependencies..."
sudo apt-get install -f -y

# --- Clean up ---
rm -f "$TMP_DEB"

# --- Verify install ---
if dpkg -s "$PACKAGE" &>/dev/null; then
  echo "✅ $PACKAGE installed successfully."
else
  echo "❌ $PACKAGE installation failed."
  exit 1
fi

exit 0
