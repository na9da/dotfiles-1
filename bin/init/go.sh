#!/bin/bash

if [ `/usr/bin/whoami` != "root" ] ; then
    echo "You must be root."
    exit 1
fi

# Add some PPAs
add-apt-repository ppa:launchpad/ppa
add-apt-repository ppa:openjdk/ppa

# grrr... vagrant doesn't work with regular virtualbox; needs Oracle's.
echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) non-free" > /etc/apt/sources.list.d/virtualbox.list
wget -O /etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list 

sudo apt-get --quiet update
wget -O /tmp/vbox.asc http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc
apt-key add /tmp/vbox.asc
sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring
sudo apt-get --quiet update

# get the minimum to bootstrap
apt-get install git-core zile build-essential mpd ruby-full ruby-dev
apt-get build-dep emacs-snapshot w3m-el
mkdir ~/src

# don't write atimes
chattr +A /

# other random debs
wget http://eion.robbmob.com/skype4pidgin.deb
dpkg -i skype4pidgin.deb

chown -R phil ~

exit 0
