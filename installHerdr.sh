#!/usr/bin/env bash
# Install herdr ("tmux for AI agents") and register the herdr-side of herdr-splits
# from the vendored submodule — declaratively, via `herdr plugin link` (no `herdr plugin install`).
# Called from ./setup; safe to run standalone and idempotent.
set -e

case "$(uname -s)" in
Linux | Darwin) ;;
*)
  echo "herdr: skipping install on $(uname -s) (Linux/macOS only)"
  exit 0
  ;;
esac

_dotfilesDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

if ! type herdr >/dev/null 2>&1; then
  echo "Installing herdr..."
  if type brew >/dev/null 2>&1; then
    brew install herdr
  else
    curl -fsSL https://herdr.dev/install.sh | sh
  fi
else
  echo "herdr already installed ($(herdr --version 2>/dev/null))"
fi

# herdr-side half of herdr-splits.nvim. The Neovim half loads from the same submodule
# via lazy.nvim (config/nvim/lua/plugins/herdr-splits.lua).
_splits="$_dotfilesDir/submodules/herdr-splits.nvim"
if [ ! -f "$_splits/herdr-plugin.toml" ]; then
  echo "Warning: $_splits/herdr-plugin.toml not found — run 'git submodule update --init' first; skipping link"
  exit 0
fi

if type herdr >/dev/null 2>&1; then
  if herdr plugin list 2>/dev/null | grep -q "herdr-splits"; then
    echo "herdr-splits plugin already linked"
  else
    echo "Linking herdr-splits (herdr side) from $_splits"
    herdr plugin link "$_splits" || echo "Warning: 'herdr plugin link' failed — run it manually once herdr is set up"
  fi
fi
