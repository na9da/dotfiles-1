#!/bin/bash

# Bootstrap a fresh Debian install based on my dotfiles and gems/debs lists.

set -e

ME=$1

cd /home/$ME/bin/init

# don't write atimes
chattr +A /

echo "Installing packages via apt-get and rubygems..."

apt-get install -y $(cat debs | tr '\n' ' ')

sudo -u $ME gem install --user --no-rdoc --no-ri bundler ghi bananajour cheat

cp xsession.desktop /usr/share/xsessions/xsession.desktop

# No thank you
rm -rf /home/$ME/Desktop /home/$ME/Documents /home/$ME/Music \
    /home/$ME/Pictures /home/$ME/Public \ /home/$ME/Templates \
    /home/$ME/Videos /home/$ME/Downloads

if [ -f /etc/mpd.conf ]; then
  mkdir /home/$ME/.mpd
  chown $ME /home/$ME/.mpd
  cp mpd.conf /etc
fi

if [ ! -x /usr/bin/heroku ]; then
  wget -qO- https://toolbelt.heroku.com/install.sh | bash
fi

sudo -u $ME gconftool --load /home/$ME/.gconf.xml

# do not want
apt-get remove gnash gnash-common browser-plugin-gnash || true

echo "All done! Happy hacking."
