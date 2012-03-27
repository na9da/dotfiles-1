#!/bin/bash

set -e -u

ME=$1

case `uname -a` in
    *x86_64*) NIX_DEB=http://hydra.nixos.org/build/2337746/download/1/nix_0-1_amd64.deb ;;
    *) NIX_DEB=http://hydra.nixos.org/build/2337727/download/1/nix_0-1_i386.deb ;;
esac

if [ ! -x /usr/bin/nix-env ]; then
    cd /tmp
    wget $NIX_DEB
    sudo dpkg -i nix_0-1-*.deb
    sudo apt-get -f install
    nix-channel --add http://nixos.org/releases/nixpkgs/channels/nixpkgs-unstable
    nix-channel --update
    echo "Nix installed; please source /etc/profile.d/nix.sh"
fi

# wtf; firefox comes with flash by default. get the no-plugins version
nix-env -i $(nix-env -qaP firefox | grep -v plugins | head -n 1 | cut -f 2- -d " ")
nix-env -i $(ruby -ryaml -e "puts YAML.load_file('nix.yml').join ' '")

sudo chown -R $ME /nix
