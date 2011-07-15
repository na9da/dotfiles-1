#!/bin/bash

if [ `/usr/bin/whoami` != "root" ] ; then
    echo "You must be root."
    exit 1
fi
# get the minimum to bootstrap
apt-get install -y git-core zile build-essential mpd ruby-full ruby-dev \
    python-software-properties
apt-get build-dep emacs-snapshot

echo "APT::Install-Recommends \"0\";" > /etc/apt/apt.conf.d/50norecommends

# Virtualbox, since vagrant doesn't work with the free version
apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
cd /tmp
sudo apt-get install virtualbox-4.0
wget http://download.virtualbox.org/virtualbox/4.0.8/Oracle_VM_VirtualBox_Extension_Pack-4.0.8-71778.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.0.8-71778.vbox-extpack

mkdir ~/src

# don't write atimes
chattr +A /

# other random debs
# wget http://eion.robbmob.com/skype4pidgin.deb
# dpkg -i skype4pidgin.deb

chown -R phil ~

exit 0
