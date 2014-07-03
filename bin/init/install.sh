#!/bin/bash

# Bootstrap a fresh Debian install based on my dotfiles and package lists.

set -e

ME=$1

cd /home/$ME/bin/init

# don't write atimes
chattr +A /

echo "Installing packages via apt-get and rubygems..."

apt-get install -y $(cat debs | tr '\n' ' ')

sudo -u $ME gem install --user --no-rdoc --no-ri bundler

cp xsession.desktop /usr/share/xsessions/xsession.desktop

# No thank you
rm -rf /home/$ME/Desktop /home/$ME/Documents /home/$ME/Music \
    /home/$ME/Pictures /home/$ME/Public /home/$ME/Templates \
    /home/$ME/Videos /home/$ME/Downloads

if [ -f /etc/mpd.conf ]; then
  mkdir /home/$ME/.mpd
  chown $ME /home/$ME/.mpd
  cp mpd.conf /etc
fi

sudo -u $ME gconftool --load /home/$ME/.gconf.xml

# Other installs

cd ~/.dotfiles/dwm && sudo -u $ME make

if [ ! -x /home/$ME/bin/lein2 ]; then
    wget -O /home/$ME/bin/lein2 \
      https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
    chmod +x /home/$ME/bin/lein2
    chown $ME /home/$ME/bin/lein2
fi

if [ ! -x /usr/bin/heroku ]; then
  wget -qO- https://toolbelt.heroku.com/install.sh | bash
fi

sudo -u $ME ff.sh

# do not want
apt-get remove gnash gnash-common browser-plugin-gnash || true

echo "All done! Happy hacking."
