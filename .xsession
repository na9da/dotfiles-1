#!/bin/bash

source ~/.profile

# key board
xinput --set-button-map "TPPS/2 IBM TrackPoint" 1 2 3 4 5 6
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Middle Button Emulation" 8 1
setxkbmap -option ctrl:nocaps dvorak # obviously

# the "prev page" and "next page" keys near the arrows should be pgup/pgdown
xmodmap -e "keycode 166 = Prior"
xmodmap -e "keycode 167 = Next"

# utilities
xrdb ~/.Xdefaults
unclutter -idle 1 &

# I get by with a little help from gnome/xfce
gnome-settings-daemon & # fonts and stuff
gnome-screensaver & # for the lock-screen
xfce4-power-manager &

if [ $XFCE != "" ]; then
    exec startxfce4
else
    exec emacs
fi
