#!/bin/bash

mpg321 ~/bin/init/tardis.mp3 &
source ~/.profile

# middle-click-scroll
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Middle Button Emulation" 8 1

ctrl-fix

# gnome stuff
gnome-settings-daemon &
gnome-power-manager &
gnome-screensaver & # for the lock-screen
gnome-panel & # for the wifi control
nm-applet &
nautilus --no-default-window & # handles mounting of volumes

# utilities
ssh-add &
xbindkeys &
unclutter -idle 1 &

# progs
conkeror &

exec xmonad
