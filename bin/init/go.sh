#!/bin/bash

if [ `/usr/bin/whoami` != "root" ] ; then
    echo "You must be root."
    exit 1
fi

# Add some PPAs
add-apt-repository ppa:launchpad/ppa
add-apt-repository ppa:openjdk/ppa
apt-get update

# get the minimum to bootstrap
apt-get install git-core git-svn zile build-essential bison autoconf ruby1.8 ri1.8 rdoc1.8 irb1.8 ruby1.8-dev mpd
apt-get build-dep emacs-snapshot w3m-el
mkdir ~/src

# gotta have my remote X!
sed -i s/DisallowTCP=true/DisallowTCP=false/ /etc/gdm/gdm.conf

# don't write atimes
chattr +A /

# other random debs
wget http://eion.robbmob.com/skype4pidgin.deb
dpkg -i skype4pidgin.deb

chown -R phil ~

exit 0
