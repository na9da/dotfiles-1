#!/bin/bash

mpg321 ~/bin/init/tardis.mp3 &
source ~/.profile

# utilities
ctrl-fix
xrdb ~/.Xdefaults
xbindkeys &
unclutter -idle 1 &
ssh-add & # this doesn't seem to work

# progs
conkeror &

gnome-settings-daemon &
gnome-power-manager &
gnome-screensaver & # for the lock-screen
nautilus --no-default-window & # handles mounting of volumes

exec xmonad
