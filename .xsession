#!/bin/bash

source ~/.profile

# key board
xinput --set-button-map "TPPS/2 IBM TrackPoint" 1 2 3 4 5 6
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Middle Button Emulation" 8 1

setxkbmap dvorak
setxkbmap -option ctrl:nocaps
xmodmap -e "keycode 166 = Prior"
xmodmap -e "keycode 167 = Next"

# in case caps lock gets stuck on use this:
# python -c 'from ctypes import *; X11 = cdll.LoadLibrary("libX11.so.6"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'

# utilities
xrdb ~/.Xdefaults
unclutter -idle 3 &
xcompmgr -c -f -D 1 &
xbindkeys &

# progs
firefox -P main -noremote &
firefox -P js -noremote &
thunar --daemon &

# I get by with a little help from xfce
gnome-settings-daemon &
gnome-screensaver & # for the lock-screen
xfce4-power-manager &

gsettings set org.gnome.settings-daemon.plugins.cursor active false

# redshift -l 16:98 &

exec awesome
