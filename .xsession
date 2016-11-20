#!/bin/bash

source ~/.profile

# key board
xinput --set-button-map "TPPS/2 IBM TrackPoint" 1 2 3 4 5 6
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Middle Button Emulation" 8 1
setxkbmap -option ctrl:nocaps

# utilities
xrdb ~/.Xdefaults
unclutter -idle 1 &
# dunst -nb "#000000" &
xcompmgr -c -f -D 1 &
xbindkeys &
feh --bg-fill docs/images/9and9.jpg

# progs
firefox &
# proxiedfox &
thunar --daemon &

# I get by with a little help from xfce
gnome-settings-daemon &
xfce4-power-manager &
gnome-screensaver & # for the lock-screen

# redshift -l 16:98 &

startxfce4
