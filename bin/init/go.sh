#!/bin/bash

# Check out dotfiles and initiate bootstrap

set -e

if [ `whoami` != "root" ] ; then
  echo "You must be root."
  exit 1
fi

echo "APT::Install-Recommends \"0\";" > /etc/apt/apt.conf.d/50norecommends

apt-get update
apt-get install -y git zile ruby1.9.1

if [ ! -r ~/.dotfiles ]; then
  echo "Checking out dotfiles..."
  if [ ssh-add -l ]; then
    DOTFILES_URL=git@github.com:technomancy/dotfiles.git
  else
    DOTFILES_URL=git://github.com/technomancy/dotfiles.git
  fi
  ME=phil
  getent passwd phil || ME=technomancy
  getent passwd technomancy || ME=vagrant
  sudo -u $ME git clone $DOTFILES_URL ~/.dotfiles
fi

~/.dotfiles/bin/link-dotfiles

exec ~/.dotfiles/bin/install.sh
