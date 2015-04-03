# Additional settings for crouton (chromebook) chroot
if [ -z $_isNotCroutonEnv ] && type croutonversion &>/dev/null; then
  if [ -z $_croutonSwappedCtrl ]; then
    # Swap Ctrl and Search keys for ChromeOS Crouton chroots
    # Note: This works well with the crouton 'keyboard' target
    # Credit for this snippet: http://goo.gl/O8zaBR
    # echo "Swapping Control and Search keys in Crouton"
    xmodmap -e "keycode 133 = Control_L"
    xmodmap -e "keycode 37 = Overlay1_Enable"
    xmodmap -e "add control = Control_L"
    xmodmap -e "remove control = Overlay1_Enable"
    export _croutonSwappedCtrl=1
  fi
else
  export _isNotCroutonEnv=1
fi
