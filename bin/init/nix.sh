#!/bin/bash

set -e

ME=$1

case `uname -a` in
    *x86_64*) NIX_PATH=565025/download/1/nix_0.16-1_amd64.deb ;;
    *) NIX_PATH=565031/download/1/nix_0.16-1_i386.deb ;;
esac

if [ ! -x /usr/bin/nix-env ]; then
    cd /tmp
    wget -O /tmp/nix.deb http://hydra.nixos.org/build/$NIX_PATH
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

# wtf; firefox comes with flash by default. get the no-plugins version
sudo -u $ME nix-env -i $(nix-env -qaP firefox | grep -v plugins | head -n 1 | cut -f 2- -d " ")
sudo -u $ME nix-env -i $(nix-env -qa emacs | sort | tail -n 1)
sudo -u $ME nix-env -i tmux
