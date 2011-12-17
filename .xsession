#!/bin/bash

source ~/.profile

# middle-click-scroll
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Middle Button Emulation" 8 1

# fix control
xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'clear Lock'
xmodmap -e 'add Control = Control_L'

# gnome stuff
gnome-settings-daemon &
gnome-power-manager &
nm-applet &
nautilus --no-default-window & # handles mounting of volumes

# utilities
ssh-add &
xbindkeys &
unclutter -idle 1 &
feh --bg-scale ~/documents/images/rosemary.jpg
xrdb -merge ~/.Xdefaults

# progs
conkeror &

exec xmonad
