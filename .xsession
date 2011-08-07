#!/bin/bash

source ~/.profile

devilspie &
xbindkeys &
unclutter -idle 0.5 &

xrdb -merge ~/.Xdefaults
xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'clear Lock'
xmodmap -e 'add Control = Control_L'

ssh-add &

exec gnome-session
