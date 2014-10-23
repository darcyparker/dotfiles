#!/usr/bin/env bash
#Note: Surround $_frontPath in rare case there are spaces in it
if [ -z "$_frontPath" ]; then
  # Move (or Add) /usr/local/bin to the front of the path
  [ -d /usr/local/bin ] && _frontPath=/usr/local/bin

  #THIS BLOCK is SLOW!!!
  # Move (or Add) npm's bin folder to the front of the path
  # Often $NPMPREFIXBIN=/usr/local/bin, so I add this before $HOME/.local/bin
  if [[ ${ENV_NAME} != "cygwin" ]] && [[ ${ENV_NAME} != "mingw32" ]]; then
    if type npm &>/dev/null; then
      _NPMPREFIXBIN=$(npm config get prefix)/bin
      [ "$_NPMPREFIXBIN" != "/usr/local/bin" ] && _frontPath=${_NPMPREFIXBIN}:${_frontPath}
      unset _NPMPREFIXBIN
    fi
  fi

  # Move (or Add) /usr/local/bin to the front of the path
  [ -d $HOME/.local/bin ] && _frontPath=${HOME}/.local/bin:${_frontPath}

  # if there is a bin folder in home, add it to front of  PATH
  [ -d $HOME/bin ] && _frontPath=${HOME}/bin:${_frontPath}

  export _frontPath=$_frontPath;

  #For speed reasons, sed is called once at end
  export PATH=${_frontPath}:$(echo $PATH | sed -e "s;\(:\?/usr/local/bin\)|\(:\?$_NPMPREFIXBIN\)|\(:\?$HOME/.local/bin\)|\(:\?$HOME/bin\);;")
fi
