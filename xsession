#!/bin/sh

###xsetroot -cursor_name left_ptr
###xset r rate 200 30 # keyboard repeat rate.

# kmix &
# kpackagekit-smart-icon &

# Uncomment to use trayer, which is a dock on xmobar for applets and such.
# Not having the "SetPartialStrut true" option means that xmobar wont expand itself to be as tall as trayer
trayer --edge top --align right --height 0 --width 4 --SetDockType true --transparent true --expand true --alpha 223 &


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
