#!/usr/bin/env bash
# Report a git segment (matching Darcy's __git_ps1 bash prompt, minus stash) as herdr
# workspace metadata (token: git), so the sidebar `$git` row token mirrors the shell prompt.
#
# Symbols come straight from git-prompt.sh: * unstaged, + staged, % untracked (boolean),
# < behind, > ahead, <> diverged, = up-to-date. Stash ($) is intentionally omitted.
#
# Usage:
#   herdr-git-status.sh                 # uses $HERDR_WORKSPACE_ID and $PWD (from a herdr pane)
#   herdr-git-status.sh <ws_id> [dir]   # explicit (for testing)
set -u
command -v herdr >/dev/null 2>&1 || exit 0

WS="${1:-${HERDR_WORKSPACE_ID:-}}"
DIR="${2:-$PWD}"
[ -n "$WS" ] || exit 0

# Load git-prompt.sh if __git_ps1 isn't already defined (e.g. non-interactive shell).
if ! type __git_ps1 >/dev/null 2>&1; then
  for f in "$HOME/.bash/utilities/git-prompt.sh" \
           /usr/share/git-core/contrib/completion/git-prompt.sh \
           /etc/bash_completion.d/git-prompt; do
    [ -r "$f" ] && . "$f" && break
  done
fi

if ! git -C "$DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  herdr workspace report-metadata "$WS" --source git --clear-token git >/dev/null 2>&1
  exit 0
fi

full=""
if type __git_ps1 >/dev/null 2>&1; then
  full=$(cd "$DIR" 2>/dev/null &&
    GIT_PS1_SHOWDIRTYSTATE=1 \
    GIT_PS1_SHOWUNTRACKEDFILES=1 \
    GIT_PS1_SHOWUPSTREAM=auto \
    GIT_PS1_SHOWSTASHSTATE= \
    GIT_PS1_SHOWCOLORHINTS= \
    __git_ps1 "%s")
fi

# __git_ps1 "%s" => "<branch> <symbols>" (branch names never contain spaces).
# herdr's built-in `branch` token shows the branch, so keep only the symbols here.
sym="${full#* }"
[ "$sym" = "$full" ] && sym="" # no space => clean, no symbols

if [ -n "$sym" ]; then
  herdr workspace report-metadata "$WS" --source git --token "git=${sym}" --ttl-ms 900000 >/dev/null 2>&1
else
  herdr workspace report-metadata "$WS" --source git --clear-token git >/dev/null 2>&1
fi
