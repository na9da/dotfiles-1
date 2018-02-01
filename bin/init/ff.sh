#!/bin/bash

set -e

if [ "$USER" = "root" ]; then
    echo "can't run as root"
    exit 1
fi

firefox -CreateProfile main

rm -f ~/.ff

mkdir -p ~/src
ln -s ~/.mozilla/firefox/*main/ ~/.ff
rm -f ~/.ff/user.js
ln -s ~/.dotfiles/.ff.js ~/.ff/user.js

