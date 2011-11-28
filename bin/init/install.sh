#!/bin/bash

# Bootstrap a fresh Debian install based on my dotfiles and gems/debs lists.

set -e

# don't write atimes
chattr +A /

echo "Installing packages via apt-get and rubygems..."

cd ~/bin/init
apt-get install $(ruby1.9.1 -ryaml -e "puts YAML.load_file('debs.yml').join ' '")

if [ "$DISPLAY" != "" ] ; then
  apt-get install $(ruby1.9.1 -ryaml -e "puts YAML.load_file('gui-debs.yml').join ' '")
  gem install $(ruby1.9.1 -ryaml -e "puts YAML.load_file('gems.yml').join ' '")
  cp xsession.desktop /usr/share/xsessions/xsession.desktop
fi

echo "All done! Happy hacking."

# TODO: support dyndns
# wget -q "http://$DYNUSER:$DYNPASS@members.dyndns.org/nic/update?hostname=enigma.dyn-o-saur.com&myip=$IP&wildcard=NOCHG&mx=NOCHG&backmx=NOCHG"
