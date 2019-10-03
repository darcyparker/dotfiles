#!/usr/bin/env bash
# Note: Add this to xfce autostart so you don't have to open a shell to swap the keys. 
#       See http://goo.gl/YZQcYO
if [ -z "$_capsAsCtrl" ]; then
    if [[ $(uname -a) == *galliumos* ]]; then
      #For GalliumOS: keyboard settings are in `/usr/share/X11/xkb/symbols/chromebook*`
      # * See https://wiki.galliumos.org/Media_keys_and_default_keybindings for more info
      # * Using keyboard model: Chromebook (most models) | Right alt overlay | F keys mapped to media keys
      # * Used ~/bin/keyboardScanCode.sh to find keycodes Control_L 37 and Super_L 133 to swap
      # * Used `xmodmap -pm` to find previous assignments of Super_L and Control_L so they can be removed
      #   temporarily. Then update keycode for Super_L and Control_L... And re-add the previous assignments
      # Summary of result:
      # * So capslock (search) is now Control_L
      # * right alt is Overlay1_enabled
      # * left control is super_L
      #Temporarily remove control and mod4 because the keys will be remapped
      xmodmap -e "remove control = Control_L"
      xmodmap -e "remove mod4 = Super_L"
      #Assign new keycodes for Control_L and Super_L
      xmodmap -e "keycode 133 = Control_L"
      xmodmap -e "keycode 37 = Super_L"
      # Add back control and mod4
      xmodmap -e "add control = Control_L"
      xmodmap -e "add mod4 = Super_L"
      export _capsAsCtrl=1
    else if type croutonversion &>/dev/null; then
      # It is a chromebook (crouton)
      # Swap the search key and ctrl key
      # Note: This works well with the crouton 'keyboard' target
      # Credit for this snippet: http://goo.gl/O8zaBR
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
