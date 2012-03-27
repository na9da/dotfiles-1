#!/bin/bash

set -e -u

ME=$1

case `uname -a` in
    *x86_64*) NIX_DEB=nix_0.16-1_amd64.deb ;;
    *) NIX_DEB=nix_0.16-1_i386.deb ;;
esac

# TODO: these .debs aren't even 64-bit compatible
NIX_URL=http://hydra.nixos.org/build/565025/download/1/$NIX_DEB

if [ ! -x /usr/bin/nix-env ]; then
    cd /tmp
    wget $NIX_URL
    sudo dpkg -i $NIX_DEB
    nix-channel --add http://nixos.org/releases/nixpkgs/channels/nixpkgs-unstable
    nix-channel --update
    echo "Nix installed; please source /nix/etc/profile.d/nix.sh"
fi

nix-env -i $(ruby -ryaml -e "puts YAML.load_file('nix.yml').join ' '")

chown -R $ME /nix
