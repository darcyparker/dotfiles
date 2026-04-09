#!/usr/bin/env bash
set -euo pipefail
#
# installLark.sh — Install Lark messenger on Ubuntu in a firejail sandbox.
#
# - Extracts the .deb without sudo (no root install).
# - Application files live under ~/sandboxes/lark, which firejail mounts
#   as $HOME — Lark never sees the real home directory.
# - ~/.local/bin/lark-messenger is a thin wrapper that launches the
#   sandboxed binary via firejail.
# - A .desktop file is created so Lark appears in the app launcher
#   and handles lark:// deep links.
#

# --- Internal Environment Variables (Tunable) ---
SOURCE_DEB="${1:-$(ls -t "$HOME"/Downloads/Lark-linux_x64-*.deb 2>/dev/null | head -1)}"
SANDBOX_DIR="$HOME/sandboxes/lark"
TARGET_BIN="$HOME/.local/bin/lark-messenger"
DESKTOP_OUT="$HOME/.local/share/applications/bytedance-lark.desktop"
PROFILE_OUT="$HOME/.config/firejail/lark.profile"
TEMP_EXTRACT="/tmp/lark_install_$(date +%s)"

# DNS settings for the sandbox
DNS_SERVER="1.1.1.1"

# Inside the sandbox, the home dir is $HOME
# We installed the 'opt' folder into the root of the sandbox.
# So the path INSIDE the jail is: $HOME/opt/...
INTERNAL_EXEC="$HOME/opt/bytedance/lark/bytedance-lark"

# --- 1. Pre-flight Version & Dependency Checks ---
echo "-> Checking dependencies..."

# Check if firejail is installed
if ! command -v firejail &>/dev/null; then
  echo "Error: firejail is not installed. Please install it first."
  exit 1
fi

# Check if dpkg-deb is available
if ! command -v dpkg-deb &>/dev/null; then
  echo "Error: dpkg-deb not found. Ensure you are on a Debian-based system."
  exit 1
fi

# Verify the source .deb exists
if [ ! -f "$SOURCE_DEB" ]; then
  echo "Error: Source file not found at $SOURCE_DEB"
  echo "Please update the SOURCE_DEB variable in this script."
  exit 1
fi

# Check Firejail networking configuration
# We exit here if networking is disabled, providing the user with the command to fix it.
if grep -q "^network no" /etc/firejail/firejail.config 2>/dev/null; then
  echo "-----------------------------------------------------------------------"
  echo "ERROR: Firejail networking is disabled in /etc/firejail/firejail.config"
  echo "To fix this, please run the following command manually:"
  echo ""
  echo "  sudo sed -i 's/^network no/network yes/' /etc/firejail/firejail.config"
  echo ""
  echo "Then run this script again."
  echo "-----------------------------------------------------------------------"
  exit 1
fi

# --- 2. Setup Dirs ---
mkdir -p "$SANDBOX_DIR/opt" "$SANDBOX_DIR/usr" "$TEMP_EXTRACT" || exit
mkdir -p "$(dirname "$TARGET_BIN")" "$(dirname "$DESKTOP_OUT")" "$(dirname "$PROFILE_OUT")" || exit

# --- 3. Extract & Install to Sandbox ---
echo "-> Extracting $SOURCE_DEB..."
dpkg-deb -x "$SOURCE_DEB" "$TEMP_EXTRACT" || exit

pushd "$TEMP_EXTRACT" || exit

echo "-> Installing application into sandbox..."
rm -rf "$SANDBOX_DIR/opt/bytedance"
rm -rf "$SANDBOX_DIR/share"
cp -ra opt/bytedance "$SANDBOX_DIR/opt/" || exit
# Kept for reference (e.g. upstream .desktop file); not needed at runtime.
cp -ra usr/share "$SANDBOX_DIR/usr/" || exit

# --- 4. Write Firejail Profile ---
echo "-> Writing firejail profile to $PROFILE_OUT..."
rm -f "$PROFILE_OUT"
cat <<'PROFILE' >"$PROFILE_OUT"
# Firejail profile for Lark messenger (Electron/Chromium app).
# Customise overrides in ~/.config/firejail/lark.local

# Electron's Chromium sandbox needs these two capabilities; drop everything else.
caps.drop all
caps.keep sys_admin,sys_chroot

# seccomp     — block dangerous syscalls (mount, ptrace, reboot, etc.)
# noroot      — prevent gaining root inside the sandbox (no suid, no user namespaces)
# nonewprivs  — child processes cannot acquire more privileges than the parent
# nogroups    — drop all supplementary groups (sandbox runs with primary group only)
seccomp
noroot
nonewprivs
nogroups

# Device access (private-dev keeps: snd, dri, video, urandom, shm, and a few others):
#   Audio calls (mic + speaker)   — works   (snd)
#   Receiving video from others   — works   (GPU decoding via dri)
#   Screen sharing                — works   (X11/Wayland, no device needed)
#   Webcam (your camera)          — works   (/dev/video* kept by private-dev; add "novideo" to disable)
#   DVD / TV tuner                — blocked (nodvd, notv)
private-dev
nodvd
notv

# private-tmp  — give Lark its own empty /tmp (invisible to other processes)
# disable-mnt — hide /mnt and /media (no access to mounted USB drives, NFS, etc.)
private-tmp
disable-mnt

# D-Bus: unrestricted. Filtering breaks system tray and notifications for
# Electron apps (they need to own names on the bus, not just talk to services).
# The main security boundary is --private (filesystem), seccomp, and caps.
PROFILE

# --- 5. Write the Wrapper Script ---
echo "-> Writing wrapper to $TARGET_BIN..."
rm -f "$TARGET_BIN"

# NOTE ON WRAPPER ARGUMENTS & DEEP LINKS:
# The "$@" allows arguments passed to this wrapper (like lark:// URIs)
# to be handed off correctly to the binary inside Firejail.
cat <<EOF >"$TARGET_BIN"
#!/usr/bin/env bash
# This script runs Lark inside a private home directory (~/sandboxes/lark)
firejail --profile="$PROFILE_OUT" --dns=$DNS_SERVER --env=IBUS_USE_PORTAL=1 --private="$SANDBOX_DIR" "$INTERNAL_EXEC" "\$@"
EOF
chmod +x "$TARGET_BIN" || exit

# --- 6. Host Integration ---
echo "-> Setting up Desktop shortcut..."
# Extract icon for the host to see
mkdir -p "$HOME/.local/share/icons"
rm -f "$HOME/.local/share/icons/lark.png"
cp "opt/bytedance/lark/product_logo_256.png" "$HOME/.local/share/icons/lark.png"

# NOTE ON %U AND lark:// LINKS:
# The '%U' flag is a FreeDesktop standard. It allows the desktop environment
# to pass multiple URLs to the application. This is essential for 'lark://'
# protocol handling. When you click a Lark link in your browser, the system
# uses the %U placeholder to pass that URI to this wrapper script.
rm -f "$DESKTOP_OUT"
sed -e "s|^Exec=.*|Exec=$TARGET_BIN %U|" \
  -e "s|^Icon=.*|Icon=$HOME/.local/share/icons/lark.png|" \
  -e "/^Name=/a Comment=Firejailed via $TARGET_BIN" \
  "usr/share/applications/bytedance-lark.desktop" >"$DESKTOP_OUT" || exit

echo "-> Desktop file updated: Exec=$TARGET_BIN"

popd || exit

# --- 7. Cleanup ---
rm -rf "$TEMP_EXTRACT"

echo "------------------------------------------------"
echo "Installation complete!"
echo "DNS Configured: $DNS_SERVER"
echo "Deep linking (lark://) enabled via %U flag."
echo "Check sandboxed apps: \`firejail --list\`"
echo "------------------------------------------------"
