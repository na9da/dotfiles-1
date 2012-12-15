#!/bin/bash

# Check out dotfiles and initiate bootstrap

set -e

if [ `whoami` != "root" ] ; then
  echo "You must be root."
  exit 1
fi

echo "APT::Install-Recommends \"0\";" > /etc/apt/apt.conf.d/50norecommends

apt-get update && apt-get install -y git zile ruby1.9.1 sudo

if [ "$ME" = "" ]; then
  export ME=phil
  getent passwd phil || \
    (export ME=technomancy && getent passwd technomancy || \
     export ME=vagrant)
fi

usermod -a -G sudo $ME

sed -i s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/ /etc/default/grub
update-grub

sed -i s/XKBOPTIONS=""/XKBOPTIONS="ctrl:nocaps"/ /etc/default/keyboard
dpkg-reconfigure -phigh console-setup

if [ ! -r /home/$ME/.dotfiles ]; then
  echo "Checking out dotfiles..."
  sudo -u $ME git clone git://github.com/technomancy/dotfiles.git \
    /home/$ME/.dotfiles
fi

sudo -u $ME /home/$ME/.dotfiles/bin/link-dotfiles

exec /home/$ME/.dotfiles/bin/init/install.sh $ME
