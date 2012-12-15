#!/bin/bash

set -e

ME=$1

NIX_DEB_URL=http://hydra.nixos.org/build/2860038/download/1/nix_1.1-1_amd64.deb

if [ ! -x /usr/bin/nix-env ]; then
    cd /tmp
    wget -O /tmp/nix.deb $NIX_DEB_URL
    dpkg -i /tmp/nix.deb || true
    apt-get -f install
    sudo chown -R $ME /nix
    sudo -u $ME nix-channel --add \
        http://nixos.org/releases/nixpkgs/channels/nixpkgs-unstable
    sudo -u $ME nix-channel --update
else
    sudo chown -R $ME /nix
fi

if [ -r /etc/profile.d/nix.sh ] ; then
    source /etc/profile.d/nix.sh
elif [ -r /usr/local/etc/profile.d/nix.sh ] ; then
    source /usr/local/etc/profile.d/nix.sh
fi

sudo -u $ME nix-env --switch-profile /nix/var/nix/profiles/default

# wtf; firefox comes with flash by default. get the no-plugins version
FIREFOX=$(nix-env -qaP firefox | grep -v plugins | head -n 1 | cut -f 2- -d " ")
EMACS=$(nix-env -qa emacs | sort | tail -n 1)
PACKAGES="tmux dmenu $EMACS $FIREFOX"

mkdir /nix
sudo chown -R $ME /nix

sudo -u $ME nix-env -i $PACKAGES
