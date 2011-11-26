#!/bin/bash

# Bootstrap a fresh Ubuntu install based on my dotfiles and gems/debs lists.

set -e

if [ `whoami` != "root" ] ; then
  echo "You must be root."
  exit 1
fi

if [ ! -f /etc/apt/apt.conf.d/50norecommends ] ; then
  echo "APT::Install-Recommends \"0\";" > /etc/apt/apt.conf.d/50norecommends
fi

# Bootstrap
apt-get update
apt-get install -y git zile build-essential python-software-properties ruby1.9.1-full curl gnupg

echo "deb http://toolbelt.herokuapp.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
curl http://toolbelt.herokuapp.com/apt/release.key | apt-key add -

# don't write atimes
chattr +A /

if [ ! -r ~/.dotfiles ]; then
  if [ ssh-add -l ]; then
    DOTFILES_URL=git@github.com:technomancy/dotfiles.git
  else
    DOTFILES_URL=git://github.com/technomancy/dotfiles.git
  fi
  ME=phil
  getent passwd phil || ME=technomancy
  getent passwd technomancy || ME=vagrant
  sudo -u $ME git clone $DOTFILES_URL ~/.dotfiles
fi

if [ -r $HOME/.bashrc ] && [ ! -h $HOME/.bashrc ] ; then
  rm $HOME/.bashrc # blow away the stock one
fi

if [ -r $HOME/.profile ] && [ ! -h $HOME/.profile ] ; then
  rm $HOME/.profile # blow away the stock one
fi

# TODO: move .gitconfig to dotfiles once ghi is fixed to work w/ token file

$HOME/.dotfiles/link-dotfiles

if [ ! -r "$HOME/.ssh/config" ]; then
  ln -s "$HOME/.dotfiles/.sshconfig" "$HOME/.ssh/config"
fi

echo "Done bootstrapping dotfiles; installing packages via apt-get and rubygems..."

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
