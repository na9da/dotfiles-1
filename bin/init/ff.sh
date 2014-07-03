#!/bin/bash

if [ "$USER" = "root" ]; then
    echo "can't run as root"
    exit 1
fi

firefox -CreateProfile phil
mkdir -p ~/src
cd ~/.mozilla/firefox/*phil/
mkdir -p keysnail
ln -s ~/.dotfiles/.keysnail-plugins keysnail/plugins

cd ~/src
if [ -d "$HOME/src/keysnail" ]; then
    cd keysnail && git fetch
else
    git clone https://github.com/mooz/keysnail.git
    cd keysnail
fi
./createpackage.sh
firefox keysnail.xpi
cd ..

if [ -d "$HOME/src/https-everywhere" ]; then
    cd https-everywhere && git fetch && cd ..
else
    git clone https://github.com/EFForg/https-everywhere.git
    cd https-everywhere
fi
./makexpi.sh
firefox pkg/*.xpi

# still needs manual "reload plugins" in keysnail plugin manager
