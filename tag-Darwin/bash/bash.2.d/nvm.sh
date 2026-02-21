#!/usr/bin/env bash
# export NVM_DIR="$HOME/.config/nvm"

# Note: Has to be sourced for each shell because $NVM_DIR/nvm.sh does not seem
# to save 100% of environment for child shells
#shellcheck disable=SC2155
if [ -z "$NVM_DIR" ]; then
  #Then try to guess/set $NVM_DIR: Two guesses for $NVM_DIR
  #1) $XDG_CONFIG_HOME/nvm ($XDG_CONFIG_HOME is typically $HOME/.config, but not always) IF $XDG_CONFIG_HOME is defined (ie running xwindows)
  #2) $HOME/.nvm
  #3) $HOME/.config/nvm
  NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "$XDG_CONFIG_HOME/nvm")"
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    export NVM_DIR #first guess was correct
  elif [ -s "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm" #second guess was correct
  elif [ -s "$HOME/.config/nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.config/nvm" #third guess was correct
  else
    #Could not guess it
    unset NVM_DIR
  fi
fi

if [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ]; then
  . "$(brew --prefix)/opt/nvm/nvm.sh"                                                                                   # This loads nvm
  [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
  #Note cdnvm is performed by ~/.bash/bash.3.d/cdnvm.sh
else
  unset NVM_DIR
fi
