#!/bin/bash

devilspie &
xbindkeys &
~/src/conkeror/contrib/run-conkeror -daemon &

xrdb -merge ~/.Xdefaults
source ~/.profile

setxkbmap -option ctrl:nocaps
gnome-do &

exec gnome-session

#gnome-settings-daemon &
#gnome-power-manager &
#nm-applet &
#exec awesome
