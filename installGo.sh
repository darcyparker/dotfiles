#!/bin/bash

# Configuration - Update this version number as Go releases new versions
GO_VERSION="1.26.1"
GO_TARBALL="go$GO_VERSION.linux-amd64.tar.gz"
GO_URL="https://go.dev/dl/$GO_TARBALL"
INSTALL_DIR="/usr/local"

echo "--- 🐹 Go Environment Sync ($GO_VERSION) ---"

# 1. Check current version to avoid redundant downloads
if command -v go &>/dev/null; then
  CURRENT_VER=$(go version | awk '{print $3}' | sed 's/go//')
  if [ "$CURRENT_VER" == "$GO_VERSION" ]; then
    echo "✅ Go is already up to date (v$GO_VERSION)."
    exit 0
  fi
  echo "🔄 Updating Go from $CURRENT_VER to $GO_VERSION..."
else
  echo "📦 Go not found. Performing fresh install of $GO_VERSION..."
fi

# 2. Download the Tarball
echo "📥 Downloading $GO_TARBALL..."
curl -L -O "$GO_URL"

# Check if download was successful
if [ ! -f "$GO_TARBALL" ] || [ "$(stat -c%s "$GO_TARBALL")" -lt 1000 ]; then
  echo "❌ Download failed. Check your internet connection or the version number."
  exit 1
fi

# 3. Clean and Extract
# We remove the old /usr/local/go before extracting to prevent file collisions
echo "🧹 Removing old installation and extracting new files..."
rm -rf "$INSTALL_DIR/go"
tar -C "$INSTALL_DIR" -xzf "$GO_TARBALL"

# 4. Cleanup
echo "🧹 Cleaning up temporary files..."
rm "$GO_TARBALL"

# 5. Verification
echo "✨ Verifying installation..."
if [ -x "$INSTALL_DIR/go/bin/go" ]; then
  # Ensure the path is available in the current subshell for the final check
  export PATH=$PATH:$INSTALL_DIR/go/bin
  go version
  echo "🎉 Go $GO_VERSION successfully installed to $INSTALL_DIR/go"
else
  echo "❌ Installation failed. /usr/local/go/bin/go not found."
  exit 1
fi

echo "--- ✅ Sync Complete ---"
