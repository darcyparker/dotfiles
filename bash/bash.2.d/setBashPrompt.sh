#!/usr/bin/env bash
# A modern, flicker-free, and robust bash prompt with git integration.

# Find and load the git prompt helper script.
if [ -f "/usr/share/git/completion/git-prompt.sh" ]; then
  # shellcheck disable=SC1091
  . "/usr/share/git/completion/git-prompt.sh"
elif [ -f "/usr/lib/git-core/git-sh-prompt" ]; then
  # shellcheck disable=SC1091
  . "/usr/lib/git-core/git-sh-prompt"
fi

# Configure the git prompt display (only if the function exists).
if type __git_ps1 &>/dev/null; then
  export GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWUPSTREAM="auto"
  export GIT_PS1_SHOWCOLORHINTS=1
fi

# --- Color Codes ---
readonly GREEN='\[\e[32m\]'
readonly WHITE='\[\e[37m\]'
readonly RED='\[\e[31m\]'
readonly CYAN='\[\e[36m\]'
readonly YELLOW='\[\e[33m\]'
readonly RESET='\[\e[0m\]'

# --- Construct the Prompt ---
PS1="${GREEN}\#${RESET} "
PS1+="${WHITE}\u${RED}@${WHITE}\h${RESET}:${CYAN}\w"

# **Only add the git part if the function was successfully loaded.**
if type __git_ps1 &>/dev/null; then
  PS1+="${YELLOW}\$(__git_ps1 ' (%s)')"
fi

PS1+="${RESET}\n\$ "
export PS1
