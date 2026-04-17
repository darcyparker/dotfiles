#!/bin/bash

# Configuration
INSTALL_PREFIX="/usr/local"
SRC_DIR="$HOME/src"
GHOSTTY_DIR="$SRC_DIR/ghostty"

echo "--- 🖥️ Syncing Ghostty Environment (Full-Copy Edition) ---"

# 1. System Dependencies (Apt)
echo "📦 Checking system libraries..."
sudo apt update && sudo apt install -y \
  libgtk-4-dev libadwaita-1-dev libfontconfig1-dev \
  libfreetype-dev libx11-dev libxkbcommon-dev libwayland-dev \
  libxcursor-dev libxi-dev libxinerama-dev libxrandr-dev libxrender-dev \
  wget tar curl git libxml2-utils python3-typing-extensions \
  libgtk4-layer-shell-dev gettext

# 2. Build Tooling (Homebrew + Zig)
echo "🍺 Verifying Brew toolchain..."
brew update && brew install blueprint-compiler libadwaita

# Ghostty requires Zig 0.15.x — Homebrew may have a newer incompatible version.
# Install the correct version directly.
ZIG_REQUIRED="0.15.2"
ZIG_INSTALL_DIR="$HOME/.local/zig-${ZIG_REQUIRED}"
ZIG_BIN="$ZIG_INSTALL_DIR/zig"

if [ ! -x "$ZIG_BIN" ]; then
  echo "⚡ Installing Zig $ZIG_REQUIRED to $ZIG_INSTALL_DIR..."
  ZIG_TARBALL="zig-x86_64-linux-${ZIG_REQUIRED}.tar.xz"
  ZIG_URL="https://ziglang.org/download/${ZIG_REQUIRED}/${ZIG_TARBALL}"
  mkdir -p "$ZIG_INSTALL_DIR"
  if ! curl -fL "$ZIG_URL" | tar -xJ --strip-components=1 -C "$ZIG_INSTALL_DIR"; then
    echo "❌ Failed to download/extract Zig from $ZIG_URL"
    rm -rf "$ZIG_INSTALL_DIR"
    exit 1
  fi
fi

export PATH="$ZIG_INSTALL_DIR:$PATH"
echo "✅ Using Zig $(zig version) from $(which zig)"

# 3. Ghostty Source Management
mkdir -p "$SRC_DIR"
if [ ! -d "$GHOSTTY_DIR" ]; then
  echo "📂 Ghostty source not found. Cloning..."
  git clone https://github.com/ghostty-org/ghostty "$GHOSTTY_DIR"
else
  echo "🔄 Ghostty source exists. Pulling latest..."
  cd "$GHOSTTY_DIR" && git pull origin main
fi

# 4. Build Ghostty
cd "$GHOSTTY_DIR" || exit 1
echo "🧹 Clearing old build artifacts..."
rm -rf .zig-cache zig-out

echo "🏗️ Building Ghostty using Zig $(zig version)..."
export PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig"

# builds to the local zig-out folder
zig build -Doptimize=ReleaseFast -fno-sys=gtk4-layer-shell

# 5. Deployment
if [ -d "zig-out" ]; then
  echo "💾 Deploying to $INSTALL_PREFIX..."
  cp -r zig-out/* "$INSTALL_PREFIX/"

  # Ensure the icon is in the standard hicolor path
  mkdir -p "$INSTALL_PREFIX/share/icons/hicolor/128x128/apps"
  cp "images/Ghostty.icon/Assets/Ghostty.png" "$INSTALL_PREFIX/share/icons/hicolor/128x128/apps/com.mitchellh.ghostty.png"

  # Sanitize the desktop file
  DESKTOP_FILE="$INSTALL_PREFIX/share/applications/com.mitchellh.ghostty.desktop"
  sed -i "s|Exec=.*|Exec=$INSTALL_PREFIX/bin/ghostty|" "$DESKTOP_FILE"
  sed -i "s|TryExec=.*|TryExec=$INSTALL_PREFIX/bin/ghostty|" "$DESKTOP_FILE"
  sed -i 's/^Icon=.*/Icon=com.mitchellh.ghostty/' "$DESKTOP_FILE"
  sed -i 's/DBusActivatable=true/DBusActivatable=false/' "$DESKTOP_FILE"

  # Ensure the ID matches the window class perfectly
  sed -i '/^StartupWMClass=/d' "$DESKTOP_FILE"
  echo "StartupWMClass=com.mitchellh.ghostty" >>"$DESKTOP_FILE"

  # Wipe local overrides
  rm -f ~/.local/share/applications/com.mitchellh.ghostty.desktop

  update-desktop-database "$INSTALL_PREFIX/share/applications"
  kbuildsycoca6 --noincremental &>/dev/null

  echo "🎉 Success! Ghostty is ready."
else
  # If we got here, 'zig build' exited 0 but didn't make the folder (unlikely)
  # or 'zig build' failed and the script continued.
  echo "❌ Build failed. zig-out not found."
  exit 1
fi

echo "--- ✅ Sync Complete ---"
