#!/bin/bash

mpg321 ~/bin/init/tardis.mp3 &
source ~/.profile

# key board
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Middle Button Emulation" 8 1
setxkbmap -option ctrl:nocaps

# utilities
xrdb ~/.Xdefaults
unclutter -idle 1 &
dunst -nb "#000000" &
xcompmgr -c -f -D 1 &

# progs
firefox &

# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=643028
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# gnome: the good parts
gnome-settings-daemon &
gnome-power-manager &
gnome-screensaver & # for the lock-screen
nautilus --no-default-window & # handles mounting of volumes

exec xmonad
