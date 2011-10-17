#!/bin/bash

# Bootstrap a fresh Ubuntu install based on my dotfiles and gems/debs lists.

if [ `whoami` != "root" ] ; then
    echo "You must be root."
    exit 1
fi

if [ ! -f /etc/apt/apt.conf.d/50norecommends ] ; then
    echo "APT::Install-Recommends \"0\";" > /etc/apt/apt.conf.d/50norecommends
fi

echo "deb http://toolbelt.herokuapp.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
curl http://toolbelt.herokuapp.com/apt/release.key | apt-key add -

# Bootstrap
apt-get update
apt-get install -y git zile build-essential python-software-properties ruby1.9.1-full

cp xsession.desktop /usr/share/xsessions/xsession.desktop

# don't write atimes
chattr +A /

if [ ! -r ~/.dotfiles ]; then
    sudo -u phil git clone git@github.com:technomancy/dotfiles.git ~/.dotfiles
fi

for f in $(ls -a ~/.dotfiles) ; do
    if [ ! -r "~/$f" ] && [ "$f" != "." ] && [ "$f" != ".." ] ; then
        ln -s "~/.dotfiles/$f" "~/$f"
    fi
done

chown -R phil ~

echo "Done bootstrapping dotfiles."

cd ~/bin/init
apt-get install $(ruby -ryaml -e "puts YAML.load_file('debs.yml').join ' '")

if [ "$DISPLAY" != "" ] ; then
    apt-get install $(ruby -ryaml -e "puts YAML.load_file('gui-debs.yml').join ' '")
    gem install $(ruby -ryaml -e "puts YAML.load_file('gems.yml').join ' '")
fi
