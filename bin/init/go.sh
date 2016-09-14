#!/bin/bash

# Check out dotfiles and initiate bootstrap

set -e

if [ `whoami` != "root" ] ; then
  echo "You must be root."
  exit 1
fi

echo "APT::Install-Recommends \"0\";" > /etc/apt/apt.conf.d/50norecommends
echo "deb http://ftp.debian.org/debian jessie-backports main" > \
     /etc/apt/sources.list.d/backports.list

apt-get update && apt-get install -y git zile sudo

if [ "$ME" = "" ]; then
  export ME=phil
fi

usermod -a -G sudo $ME

# Allow control over interfaces that the installer hard-codes
if [ -r /etc/NetworkManager/NetworkManager.conf ]; then
    sed -i s/managed=false/managed=true/ /etc/NetworkManager/NetworkManager.conf
fi

# Don't wait to boot; just go with the default.
if [ -f /etc/default/grub ]; then
    sed -i s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/ /etc/default/grub
    update-grub
fi

# Caps lock is absurd.
sed -i s/XKBOPTIONS=""/XKBOPTIONS="ctrl:nocaps"/ /etc/default/keyboard
dpkg-reconfigure -phigh console-setup

# Check repo out
if [ ! -r /home/$ME/.dotfiles ]; then
  echo "Checking out dotfiles..."
  sudo -u $ME git clone git://github.com/technomancy/dotfiles.git \
    /home/$ME/.dotfiles
fi

sudo -u $ME /home/$ME/.dotfiles/bin/link-dotfiles

exec /home/$ME/.dotfiles/bin/init/install.sh $ME
