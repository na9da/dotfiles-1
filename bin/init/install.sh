#!/bin/bash

# Bootstrap a fresh Debian install based on my dotfiles and package lists.

set -e

ME=$1

cd /home/$ME/bin/init

# don't write atimes
chattr +A /

echo "Installing packages..."

apt-get install -y $(cat debs | sed 's:#.*$::g' | tr '\n' ' ')

cp xsession.desktop /usr/share/xsessions/xsession.desktop

# No thank you
rm -rf /home/$ME/Desktop /home/$ME/Documents /home/$ME/Music \
    /home/$ME/Pictures /home/$ME/Public /home/$ME/Templates \
    /home/$ME/Videos /home/$ME/Downloads

ln -s /home/$ME/ /home/$ME/Desktop # what exactly is the point?

# if [ -f /etc/mpd.conf ]; then
#   mkdir /home/$ME/.mpd
#   chown $ME /home/$ME/.mpd
#   cp mpd.conf /etc
# fi

# Other installs

if [ ! -x /home/$ME/bin/lein2 ]; then
    wget -O /home/$ME/bin/lein2 \
      https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
    chmod +x /home/$ME/bin/lein2
    chown $ME /home/$ME/bin/lein2
fi

for rock in $(cat rocks | sed 's:#.*$::g' | tr '\n' ' '); do
    if [ "$(luarocks list $rock | grep $rock)" == "" ]; then
        sudo -iu $ME luarocks install --local $rock
    fi
done

# without this, git will ignore .authinfo.gpg
chmod +x /usr/share/doc/git/contrib/credential/netrc/git-credential-netrc
sudo -u $ME git config --global credential.helper \
     /usr/share/doc/git/contrib/credential/netrc/git-credential-netrc

sudo -iu $ME /home/$ME/bin/init/ff.sh

sudo -iu $ME emacs -Q -l /home/$ME/.emacs.d/$ME/bootstrap.el -f pnh-reinit-libs

echo "All done! Happy hacking."
