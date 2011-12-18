#!/bin/bash

# Bootstrap a fresh Debian install based on my dotfiles and gems/debs lists.

# No thank you:
rmdir Desktop Documents Music Pictures Public Templates Videos Downloads

set -e

# don't write atimes
chattr +A /

echo "Installing packages via apt-get and rubygems..."

cd /home/$ME/bin/init
apt-get install -y $(ruby1.9.1 -ryaml -e "puts YAML.load_file('debs.yml').join ' '")

if [ "$DISPLAY" != "" ] ; then
  apt-get install -y $(ruby1.9.1 -ryaml -e "puts YAML.load_file('gui-debs.yml').join ' '")
  gem1.9.1 install --no-rdoc --no-ri $(ruby1.9.1 -ryaml -e "puts YAML.load_file('gems.yml').join ' '")
  cp xsession.desktop /usr/share/xsessions/xsession.desktop
fi

./heroku.sh

echo "All done! Happy hacking."

# TODO: support dyndns on pair.io
# wget -q "http://$DYNUSER:$DYNPASS@members.dyndns.org/nic/update?hostname=enigma.dyn-o-saur.com&myip=$IP&wildcard=NOCHG&mx=NOCHG&backmx=NOCHG"
