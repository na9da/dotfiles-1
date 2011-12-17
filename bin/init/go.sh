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

export ME=phil
getent passwd phil || \
	(export ME=technomancy && getent passwd technomancy || \
	 export ME=vagrant)

usermod -a -G sudo $ME

if [ ! -r /home/$ME/.dotfiles ]; then
  echo "Checking out dotfiles..."
  if [ "`ssh-add -l`" = "The agent has no identities." ]; then
    DOTFILES_URL=git://github.com/technomancy/dotfiles.git
  else
    DOTFILES_URL=git@github.com:technomancy/dotfiles.git
  fi
  sudo -u $ME git clone $DOTFILES_URL /home/$ME/.dotfiles
fi

sudo -u $ME /home/$ME/.dotfiles/bin/link-dotfiles

exec /home/$ME/.dotfiles/bin/init/install.sh
