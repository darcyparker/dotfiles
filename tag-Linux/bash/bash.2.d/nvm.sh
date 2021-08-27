#!/usr/bin/env bash
# Note: Has to be sourced for each shell because $NVM_DIR/nvm.sh does not seem
# to save 100% of environment for child shells
#shellcheck disable=SC2155
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

if [ -s "$NVM_DIR/nvm.sh" ]; then
  #shellcheck disable=SC1090
  . "$NVM_DIR/nvm.sh" # This loads nvm

  #shellcheck disable=SC1090
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  #shellcheck disable=SC1090
  [[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

else
  unset NVM_DIR
fi

