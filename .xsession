#!/bin/bash

mpg321 -n 50 ~/bin/init/tardis.mp3 &
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
xbindkeys &
ssh-add &
srandrd monswitch

# progs
firefox &
proxiedfox &
nautilus --no-default-window --force-desktop &

# gnome: the good parts
gnome-settings-daemon &
gnome-power-manager &
gnome-screensaver & # for the lock-screen

# https://bugs.launchpad.net/ubuntu/+source/gnome-settings-daemon/+bug/1238410
dconf write /org/gnome/settings-daemon/plugins/cursor/active false
# doesn't actually work
dconf write /org/gnome/nautilus/preferences/desktop-is-home-dir true

redshift -l 16:98 &

# autossh -D 8088 -o serveraliveinterval=10 -o serveralivecountmax=3 p

exec xmonad
