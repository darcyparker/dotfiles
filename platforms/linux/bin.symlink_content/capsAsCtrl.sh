#!/usr/bin/env bash
# Note: Add this to xfce autostart so you don't have to
#       open a shell to swap the keys. See http://goo.gl/YZQcYO

if [ -z "$_capsAsCtrl" ]; then
    if [[ $(uname -a) == *galliumos* ]]; then
      # TODO
      #For GalliumOS: keyboard settings are in
      # /usr/share/X11/xkb/symbols/chromebook*
      # See https://wiki.galliumos.org/Media_keys_and_default_keybindings for more info
      echo "Swapping for galliumos todo"
    else if type croutonversion &>/dev/null; then
      # It is a chromebook (crouton)
      # Swap the search key and ctrl key
      # Note: This works well with the crouton 'keyboard' target
      # Credit for this snippet: http://goo.gl/O8zaBR
      echo "Swapping Control and Search keys in Crouton"
      xmodmap -e "keycode 133 = Control_L"
      xmodmap -e "keycode 37 = Overlay1_Enable"
      xmodmap -e "add control = Control_L"
      xmodmap -e "remove control = Overlay1_Enable"
      export _capsAsCtrl=1
    else
      #It is not chromebook. We'll just make capslock ctrl key (search key does not apply, so no swap)
      export _capsAsCtrl=1
      setxkbmap -option ctrl:nocaps
    fi
  fi
fi
