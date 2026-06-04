# Chrome web apps (Slack, etc.) on KDE Wayland + NVIDIA

Chrome "apps" — a tab saved as an app, e.g. Slack — are created through Chrome's
**UI, not by a script**: the app is registered inside a specific Chrome profile
under a generated `--app-id` (a hash of the site URL). So this is a manual recipe.
Only the generic browser launcher is scripted (`installChromeApps.sh`).

## 1. Create the app
1. In Chrome, open the site **signed in** — e.g. <https://app.slack.com/> — in the
   profile you want it under (work vs personal).
2. **⋮ menu → Cast, save, and share → Save tab as app.**
   (Older Chrome: ⋮ → More tools → Create shortcut… → tick *Open as window*.)

Chrome then creates:
- launcher: `~/.local/share/applications/chrome-<APP_ID>-<Profile>.desktop`
- icons:    `~/.local/share/icons/hicolor/*/apps/chrome-<APP_ID>-<Profile>.png`

## 2. Add the Wayland / webcam flags
A freshly-created launcher has **no** Ozone flags, so webcam & screen-share break
on Wayland + NVIDIA. Append them to its `Exec=` line:

```
--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer --ozone-platform-hint=auto --ozone-platform=wayland
```

One-liner that patches the most-recently-created Chrome app launcher (safe to re-run):

```bash
f=$(ls -t ~/.local/share/applications/chrome-*-*.desktop | head -1)
grep -q 'ozone-platform=wayland' "$f" || \
  sed -i '/^Exec=.*--app-id=/ s/$/ --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer --ozone-platform-hint=auto --ozone-platform=wayland/' "$f"
update-desktop-database ~/.local/share/applications
grep '^Exec=' "$f"     # verify
```

## 3. Pin it
Launch it, then right-click its taskbar icon → **Pin to Task Manager**. The pin
stores the `.desktop` **filename** — so don't delete or rename that file, or the
pinned icon goes dead (deleting it is exactly what broke Slack once).

## Why this isn't committed to the dotfiles repo
The `--app-id` is workspace-specific and the launcher filename embeds your Chrome
profile name — both are machine/identity-specific, and the repo is public. So
create the app per-machine with the steps above; only the generic
`google-chrome.desktop` browser launcher is version-controlled.
