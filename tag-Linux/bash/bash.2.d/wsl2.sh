# Start gnome-keyring for VS Code secret storage in WSL
# Install if missing:
#   Arch/Manjaro: sudo pacman -S gnome-keyring
#   Debian/Ubuntu: sudo apt install gnome-keyring
if [ -n "$WSL_DISTRO_NAME" ] && type gnome-keyring-daemon &>/dev/null; then
  eval "$(gnome-keyring-daemon --start --components=secrets 2>/dev/null)"
  export GNOME_KEYRING_CONTROL
fi
