#!/usr/bin/env bash
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

if [ -s "$NVM_DIR/nvm.sh" ]; then
  #shellcheck disable=SC1090
  . "$NVM_DIR/nvm.sh" # This loads nvm

  #shellcheck disable=SC1090
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  cdnvm() {
    command cd "$@" || return $?
    nvm_path=$(nvm_find_up .nvmrc | tr -d '\n')

    # If there are no .nvmrc file, use the default nvm version
    if [[ ! $nvm_path = *[^[:space:]]* ]]; then

      declare default_version;
      default_version=$(nvm version default);

      # If there is no default version, set it to `node`
      # This will use the latest version on your machine
      if [[ $default_version == "N/A" ]]; then
        nvm alias default node;
        default_version=$(nvm version default);
      fi

      # If the current version is not the default version, set it to use the default version
      if [[ $(nvm current) != "$default_version" ]]; then
        nvm use default;
      fi

    elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
      declare nvm_version
      nvm_version=$(<"$nvm_path"/.nvmrc)

      declare locally_resolved_nvm_version
      # `nvm ls` will check all locally-available versions
      # If there are multiple matching versions, take the latest one
      # Remove the `->` and `*` characters and spaces
      # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
      locally_resolved_nvm_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')

      # If it is not already installed, install it
      # `nvm install` will implicitly use the newly-installed version
      if [[ "$locally_resolved_nvm_version" == "N/A" ]]; then
        nvm install "$nvm_version";
      elif [[ $(nvm current) != "$locally_resolved_nvm_version" ]]; then
        nvm use "$nvm_version";
      fi
    fi
  }
  alias cd='cdnvm'
  cdnvm "$PWD" || exit
else
  unset NVM_DIR
fi
