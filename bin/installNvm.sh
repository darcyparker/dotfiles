#!/usr/bin/env bash

#Install nvm
if ! declare -f nvm &>/dev/null; then
  case "$(uname -s)" in
  Linux)
    unset NVM_DIR
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
    export NVM_DIR="$HOME/.config/nvm"
    mkdir -p "$HOME/.config/nvm"
    # shellcheck disable=SC1091
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
    ;;
  Darwin)
    export NVM_DIR="$HOME/.config/nvm"
    mkdir -p "$NVM_DIR"
    brew install nvm
    if [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ]; then
      # shellcheck disable=SC1091
      \. "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
      # shellcheck disable=SC1091
      [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
    else
      unset NVM_DIR
    fi
    ;;
  esac

  nvm install --lts --latest-npm #install LTS version of node and npm
  nvm alias default 'lts/*'
  nvm use default
fi

# Setup npm bash completion
COMPLETION_DIR="$(dirname "$0")/../bash/bash_completion.d"

if [ ! -e "$COMPLETION_DIR/npm.sh" ]; then
  if type npm >/dev/null 2>&1; then
    echo "Adding npm completion"
    # Create the directory path first
    mkdir -p "$COMPLETION_DIR"
    npm completion >"$COMPLETION_DIR/npm.sh"
    chmod +x "$COMPLETION_DIR/npm.sh"
  fi
fi
