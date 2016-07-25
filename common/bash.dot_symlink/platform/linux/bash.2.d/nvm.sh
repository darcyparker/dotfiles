#!/usr/bin/env bash
[ -z "$NVM_DIR" ] \
  && export NVM_DIR="$HOME/.nvm"

# Note: Has to be sourced for each shell because $NVM_DIR/nvm.sh does not seem
# to save 100% of environment for child shells
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
