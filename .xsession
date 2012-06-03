#!/bin/bash

# mpg321 ~/bin/init/tardis.mp3 &
source ~/.profile

# utilities
ctrl-fix
xrdb -merge ~/.Xdefaults
ssh-add &
xbindkeys &
devilspie &
unclutter -idle 1 &

# progs
conkeror &

exec gnome-session
