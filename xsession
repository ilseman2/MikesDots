#!/bin/sh

###xsetroot -cursor_name left_ptr
###xset r rate 200 30 # keyboard repeat rate.

# kmix &
# kpackagekit-smart-icon &

# Uncomment to use trayer, which is a dock on xmobar for applets and such.
#trayer --edge top --align right --height 1 --width 5 --SetDockType true --SetPartialStrut true --expand true --tint 0x555555 --alpha 225 &


# Uncomment to enable networkmanager applet
#exec nm-applet --sm-disable &

# Start daemons
exec emacs --daemon &
exec urxvtd -f &

# Start kmix
exec kmix &

# Swap capslock and control, amongst other functions
xmodmap ~/.xmodmap

exec ck-launch-session xmonad
