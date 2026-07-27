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

# 2. Build Tooling (Homebrew)
echo "🍺 Verifying Brew toolchain..."
brew update && brew install blueprint-compiler libadwaita

# 3. Ghostty Source Management
mkdir -p "$SRC_DIR"
if [ ! -d "$GHOSTTY_DIR" ]; then
  echo "📂 Ghostty source not found. Cloning..."
  git clone https://github.com/ghostty-org/ghostty "$GHOSTTY_DIR"
else
  echo "🔄 Ghostty source exists. Pulling latest..."
  cd "$GHOSTTY_DIR" && git pull origin main
fi

# 4. Zig Toolchain
# Ghostty pins the exact Zig version it needs in build.zig.zon. Read it from
# there so this script never goes stale when Ghostty bumps the requirement
# (Homebrew's zig drifts to whatever is newest, which is often incompatible).
ZIG_REQUIRED="$(grep -oP '\.minimum_zig_version\s*=\s*"\K[^"]+' "$GHOSTTY_DIR/build.zig.zon")"
if [ -z "$ZIG_REQUIRED" ]; then
  echo "❌ Could not read minimum_zig_version from $GHOSTTY_DIR/build.zig.zon"
  exit 1
fi
ZIG_INSTALL_DIR="$HOME/.local/zig-${ZIG_REQUIRED}"
ZIG_BIN="$ZIG_INSTALL_DIR/zig"

if [ ! -x "$ZIG_BIN" ]; then
  echo "⚡ Installing Zig $ZIG_REQUIRED to $ZIG_INSTALL_DIR..."
  ZIG_TARBALL="zig-x86_64-linux-${ZIG_REQUIRED}.tar.xz"
  # Tagged releases live under /download/<ver>/; dev (nightly) builds under /builds/.
  case "$ZIG_REQUIRED" in
    *-*) ZIG_URL="https://ziglang.org/builds/${ZIG_TARBALL}" ;;
    *) ZIG_URL="https://ziglang.org/download/${ZIG_REQUIRED}/${ZIG_TARBALL}" ;;
  esac
  mkdir -p "$ZIG_INSTALL_DIR"
  if ! curl -fL "$ZIG_URL" | tar -xJ --strip-components=1 -C "$ZIG_INSTALL_DIR"; then
    echo "❌ Failed to download/extract Zig from $ZIG_URL"
    rm -rf "$ZIG_INSTALL_DIR"
    exit 1
  fi
fi

export PATH="$ZIG_INSTALL_DIR:$PATH"
echo "✅ Using Zig $(zig version) from $(which zig)"

# 5. Build Ghostty
cd "$GHOSTTY_DIR" || exit 1
echo "🧹 Clearing old build artifacts..."
rm -rf .zig-cache zig-out

export PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig"
BUILD_FLAGS=(-Doptimize=ReleaseFast -fno-sys=gtk4-layer-shell)

# Pre-fetch ALL dependencies (including lazy ones) before the long compile.
# Zig pulls 40+ packages over many concurrent TLS connections at once; on
# networks with TLS inspection some simultaneous handshakes get reset — failing
# with "TlsInitializationFailed" or occasionally hanging. --fetch=all also grabs
# lazy deps (spirv-cross, glslang, dcimgui, ...) that plain --fetch skips and
# that would otherwise only download partway through the compile, so the build
# below runs fully offline from the cache (~/.cache/zig). The retry loop plus a
# per-attempt timeout make a transient failure or hang recoverable instead of
# wasting the whole build.
echo "📥 Fetching Ghostty dependencies (incl. lazy)..."
fetch_ok=0
for attempt in 1 2 3 4 5 6 7 8; do
  if timeout 180 zig build --fetch=all "${BUILD_FLAGS[@]}"; then
    fetch_ok=1
    break
  fi
  echo "⚠️  Fetch attempt $attempt failed; retrying in $((attempt * 3))s..."
  sleep "$((attempt * 3))"
done
if [ "$fetch_ok" -ne 1 ]; then
  echo "❌ Could not fetch Ghostty dependencies after multiple attempts."
  exit 1
fi

echo "🏗️ Building Ghostty using Zig $(zig version)..."
# builds to the local zig-out folder
zig build "${BUILD_FLAGS[@]}"

# 6. Deployment
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
