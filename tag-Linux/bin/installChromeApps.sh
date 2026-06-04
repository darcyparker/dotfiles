#!/usr/bin/env bash
set -euo pipefail
#
# installChromeApps.sh — Install the Google Chrome browser launcher with the
# Wayland/PipeWire flags this KDE-Wayland + NVIDIA box needs for webcam and
# screen-share. Idempotent and fully generic — safe in a public repo. Re-run
# any time Chrome/KDE rewrites the launcher.
#
# To add a Chrome WEB APP (e.g. Slack), see chrome-web-apps.md next to this
# script — it's a manual Chrome flow (Cast, save, and share → Save tab as app),
# not scriptable, and the result is machine-specific so it stays out of git.

APPS="$HOME/.local/share/applications"

# The first-launched Chrome instance sets the display backend for the session.
OZONE="--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer --ozone-platform-hint=auto --ozone-platform=wayland"

mkdir -p "$APPS"
cat >"$APPS/google-chrome.desktop" <<EOF
[Desktop Entry]
Actions=new-window;new-private-window;
Categories=Network;WebBrowser;
Comment=Access the Internet
Exec=/usr/bin/google-chrome-stable $OZONE %U
GenericName=Web Browser
Icon=google-chrome
MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/google-chrome;
Name=Google Chrome
StartupNotify=true
Terminal=false
Type=Application
Version=1.0

[Desktop Action new-private-window]
Exec=/usr/bin/google-chrome-stable $OZONE --incognito
Name=New Incognito Window

[Desktop Action new-window]
Exec=/usr/bin/google-chrome-stable $OZONE
Name=New Window
EOF

update-desktop-database "$APPS" 2>/dev/null || true
command -v kbuildsycoca6 >/dev/null 2>&1 && kbuildsycoca6 >/dev/null 2>&1 || true

echo "Installed $APPS/google-chrome.desktop (Wayland/webcam flags applied)."
