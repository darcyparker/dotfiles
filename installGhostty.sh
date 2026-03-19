#!/bin/bash

# Configuration
ZIG_TARGET_VER="0.15.2"
ZIG_FILENAME="zig-x86_64-linux-$ZIG_TARGET_VER.tar.xz"
ZIG_INSTALL_DIR="/usr/local/zig"
ZIG_BIN_DIR="/usr/local/bin"
SRC_DIR="$HOME/src"
GHOSTTY_DIR="$SRC_DIR/ghostty"
ZIG_CMD="zig-$ZIG_TARGET_VER"

echo "--- 🖥️ Syncing Workstation Environment ($ZIG_TARGET_VER) ---"

# 1. System Dependencies (Kubuntu/Ubuntu)
echo "📦 Checking system libraries..."
sudo apt update && sudo apt install -y \
  libgtk-4-dev libadwaita-1-dev libfontconfig1-dev \
  libfreetype6-dev libx11-dev libxkbcommon-dev libwayland-dev \
  libxcursor-dev libxi-dev libxinerama-dev libxrandr-dev libxrender-dev \
  wget tar curl git

# 2. Zig Version Management
mkdir -p "$ZIG_INSTALL_DIR"
pushd "$ZIG_INSTALL_DIR" >/dev/null || exit 1

# Download/Extract if the specific version folder is missing
if [ ! -d "zig-x86_64-linux-$ZIG_TARGET_VER" ]; then
  echo "⚠️ Zig $ZIG_TARGET_VER folder not found. Downloading..."
  curl -L -O "https://ziglang.org/download/$ZIG_TARGET_VER/$ZIG_FILENAME"

  # Lint-friendly one-liner check for 404/corruption
  if [ ! -f "$ZIG_FILENAME" ] || [ "$(stat -c%s "$ZIG_FILENAME")" -lt 1000 ]; then
    echo "❌ Download failed. Check URL."
    popd || exit >/dev/null
    exit 1
  fi

  echo "Extracting $ZIG_FILENAME..."
  tar xf "$ZIG_FILENAME"
else
  echo "✅ Folder zig-x86_64-linux-$ZIG_TARGET_VER already exists."
fi

# 3. Update Symlinks
echo "🔗 Updating symlinks..."
# Internal link: /usr/local/zig/zig -> 0.15.2
ln -sfn "$ZIG_INSTALL_DIR/zig-x86_64-linux-$ZIG_TARGET_VER/zig" "$ZIG_INSTALL_DIR/zig"
# Global default: /usr/local/bin/zig -> 0.15.2
# ln -sfn "$ZIG_INSTALL_DIR/zig-x86_64-linux-$ZIG_TARGET_VER/zig" "$ZIG_BIN_DIR/zig"
# Versioned alias: /usr/local/bin/zig-0.15.2 -> 0.15.2
ln -sfn "$ZIG_INSTALL_DIR/zig-x86_64-linux-$ZIG_TARGET_VER/zig" "$ZIG_BIN_DIR/$ZIG_CMD"

popd || exit >/dev/null # Back from /usr/local/zig

# 4. Ghostty Source Management
mkdir -p "$SRC_DIR"
if [ ! -d "$GHOSTTY_DIR" ]; then
  echo "📂 Ghostty source not found. Cloning repository..."
  git clone https://github.com/ghostty-org/ghostty "$GHOSTTY_DIR"
else
  echo "🔄 Ghostty source exists. Pulling latest..."
  pushd "$GHOSTTY_DIR" >/dev/null || exit 1
  git pull origin main
  popd || exit >/dev/null
fi

# 5. Build Ghostty
pushd "$GHOSTTY_DIR" >/dev/null || exit 1

echo "🧹 Clearing old build artifacts and cache..."
rm -rf .zig-cache zig-out

echo "🏗️ Building Ghostty using $ZIG_CMD..."
# Using the versioned command specifically
"$ZIG_CMD" build -Doptimize=ReleaseFast

# 6. Deployment Verification
if [ -f "zig-out/bin/ghostty" ]; then
  echo "💾 Copying fresh Ghostty binary to $ZIG_BIN_DIR..."
  cp zig-out/bin/ghostty "$ZIG_BIN_DIR/"
  echo "🎉 Success! Ghostty is ready for work."
else
  echo "❌ Build failed. Check the logs above."
  popd || exit >/dev/null
  exit 1
fi

popd || exit >/dev/null # Final exit from ghostty dir
echo "--- ✅ Sync Complete ---"
