#!/usr/bin/env bash
if [ -z "$_isNotCroutonEnv" ] && type croutonversion &>/dev/null; then
  # For crouton (chromebook) chroot
  # Swap the search key and ctrl key
  if [ -z "$_croutonSwappedCtrl" ]; then
    # Swap Ctrl and Search keys for ChromeOS Crouton chroots
    # Note: This works well with the crouton 'keyboard' target
    # Credit for this snippet: http://goo.gl/O8zaBR
    # Note: Add this to xfce autostart so you don't have to
    #       open a shell to swap the keys. See http://goo.gl/YZQcYO

    # echo "Swapping Control and Search keys in Crouton"
    xmodmap -e "keycode 133 = Control_L"
    xmodmap -e "keycode 37 = Overlay1_Enable"
    xmodmap -e "add control = Control_L"
    xmodmap -e "remove control = Overlay1_Enable"
    export _croutonSwappedCtrl=1
  fi
else
  #If not crouton, just make capslock ctrl key
  export _isNotCroutonEnv=1
  setxkbmap -option ctrl:nocaps
fi
