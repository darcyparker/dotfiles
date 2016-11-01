#!/usr/bin/env bash
#Note: Surround $_frontPath in rare case there are spaces in it
if [ -z "$_frontPath" ]; then
  local _frontPathLocal
  # Move (or Add) /usr/local/bin to the front of the path
  [ -d /usr/local/bin ] && _frontPathLocal=/usr/local/bin

  #THIS BLOCK is SLOW!!!
  # Move (or Add) npm's bin folder to the front of the path
  # Often $NPMPREFIXBIN=/usr/local/bin, so I add this before $HOME/.local/bin
  if [[ ${ENV_NAME} != "cygwin" ]] && [[ ${ENV_NAME} != "mingw64" ]] && [[ ${ENV_NAME} != "mingw32" ]]; then
    if type npm &>/dev/null; then
      _NPMPREFIXBIN=$(npm config get prefix)/bin
      [ "$_NPMPREFIXBIN" != "/usr/local/bin" ] && _frontPathLocal=${_NPMPREFIXBIN}:${_frontPathLocal}
      unset _NPMPREFIXBIN
    fi
  fi

  [ ! -z "$GOPATH" ] && _frontPathLocal=${_frontPathLocal}:${GOPATH}/bin

  [ -d "$HOME/.cargo/bin" ] && _frontPathLocal=${HOME}/.cargo/bin:${_frontPathLocal}

  # Move (or Add) /usr/local/bin to the front of the path
  [ -d "$HOME/.local/bin" ] && _frontPathLocal=${HOME}/.local/bin:${_frontPathLocal}

  # if there is a bin folder in home, add it to front of  PATH
  [ -d "$HOME/bin" ] && _frontPathLocal=${HOME}/bin:${_frontPathLocal}

  export _frontPath="$_frontPathLocal"

  #For speed reasons, sed is called once at end
fi
export PATH=${_frontPath}:$(echo $PATH | sed -e "s;\(:\?/usr/local/bin\)|\(:\?$_NPMPREFIXBIN\)|\(:\?$HOME/\.cargo/bin\)|\(:\?$HOME/\.local/bin\)|\(:\?$HOME/bin\)|\(:\?$GOPATH/bin\);;")
