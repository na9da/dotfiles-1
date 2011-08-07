#!/bin/bash

if [ `/usr/bin/whoami` != "root" ] ; then
    echo "You must be root."
    exit 1
fi

# Bootstrap
apt-get install -y git zile build-essential python-software-properties \
    ruby-full ruby-dev rubygems

echo "APT::Install-Recommends \"0\";" > /etc/apt/apt.conf.d/50norecommends

# Needs mah Emacs
wget -q -O - http://emacs.naquadah.org/key.gpg | apt-key add -
apt-add-repository "deb http://emacs.naquadah.org/ $(lsb_release -cs)"
apt-get update
apt-get install emacs-snapshot

# Virtualbox, since vagrant doesn't work with the free version
apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
cd /tmp
sudo apt-get install virtualbox-4.1
VBoxManage setproperty machinefolder $HOME/.vbox-vms # you toolbag.

mkdir -p ~/src

# don't write atimes
chattr +A /

sudo -u phil git clone git@github.com:technomancy/dotfiles.git

mv dotfiles/.* ~
mv dotfiles/* ~

chown -R phil ~

echo "Done bootstrapping, installing debs and gems."

exec $HOME/bin/init/install
