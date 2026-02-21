#!/usr/bin/env bash
# --- Load Git Helper (Cross-Platform) ---
if command -v brew >/dev/null; then
  # Only run brew prefix if not already set to keep shell start fast
  BREW_PREFIX="${BREW_PREFIX:-$(brew --prefix)}"
fi

GIT_PROMPT_LOCATIONS=(
  "/usr/share/git/completion/git-prompt.sh"
  "/usr/lib/git-core/git-sh-prompt"
  "$BREW_PREFIX/etc/bash_completion.d/git-prompt.sh"
  "/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh"
  "/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh"
)

for PROMPT_PATH in "${GIT_PROMPT_LOCATIONS[@]}"; do
  if [ -f "$PROMPT_PATH" ]; then
    # shellcheck disable=SC1090
    . "$PROMPT_PATH"
    break
  fi
done

# --- Configure Git Prompt ---
if type __git_ps1 &>/dev/null; then
  export GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWUPSTREAM="auto"
  export GIT_PS1_SHOWCOLORHINTS=1
fi

# readonly GREEN='\[\e[32m\]'
# readonly WHITE='\[\e[37m\]'
# readonly RED='\[\e[31m\]'
# readonly CYAN='\[\e[36m\]'
# readonly YELLOW='\[\e[33m\]'
# readonly RESET='\[\e[0m\]'

# --- Construct the Prompt ---

# Start with a master reset, then the green # and a space.
# The initial \[\e[0m\] resets all text attributes (color, bold, etc.),
# neutralizing any broken sequences left on the line; so prompt always starts drawing correctly.
PS1='\[\e[0m\]\[\e[32m\]\#\[\e[0m\] '
# Add the user@host part.
PS1+='\[\e[37m\]\u\[\e[31m\]@\[\e[37m\]\h\[\e[0m\]'
# Add the working directory.
PS1+=':\[\e[36m\]\w'

# Add the git part, if available. This part uses double quotes
# to allow the `$(__git_ps1 ...)` command to run.
if type __git_ps1 &>/dev/null; then
  PS1+="\[\e[33m\]\$(__git_ps1 ' (%s)')"
fi

# Add the final reset, newline, and prompt character.
PS1+='\[\e[0m\]\n\$ '

export PS1

# --- Set Cursor Fix ---
if ! declare -f _fix_cursor >/dev/null; then
  _fix_cursor() {
    printf '\e[5 q'
  }
fi

if ! [[ "$PROMPT_COMMAND" == *"_fix_cursor"* ]]; then
  PROMPT_COMMAND="_fix_cursor;$PROMPT_COMMAND"
fi
