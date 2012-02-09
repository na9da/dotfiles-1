#!/bin/bash

# Bootstrap a fresh Debian install based on my dotfiles and gems/debs lists.

ME=$1

cd /home/$ME/bin/init

# No thank you:
rmdir Desktop Documents Music Pictures Public Templates Videos Downloads

# um... dude?
update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 500
update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.1 500
update-alternatives --install /usr/bin/irb irb /usr/bin/irb1.9.1 500

set -e

# don't write atimes
chattr +A /

echo "Installing packages via apt-get and rubygems..."

apt-get install -y $(ruby -ryaml -e "puts YAML.load_file('debs.yml').join ' '")

if [ "$DISPLAY" != "" ] ; then
  apt-get install -y \
    $(ruby -ryaml -e "puts YAML.load_file('gui-debs.yml').join ' '")
  gem install --no-rdoc --no-ri \
    $(ruby -ryaml -e "puts YAML.load_file('gems.yml').join ' '")
  cp xsession.desktop /usr/share/xsessions/xsession.desktop
  sed -i s/var\/lib\/mpd\/music/home\/phil\/music/ /etc/mpd.conf
fi

./heroku.sh

echo "All done! Happy hacking."
