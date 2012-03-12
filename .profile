if [ -r /etc/profile.d/nix.sh ] ; then
    source /etc/profile.d/nix.sh
fi

export PATH=$HOME/bin:$PATH
export PATH=$HOME/.lein/bin:$PATH
export PATH=$HOME/.gem/ruby/1.9.1/bin:/var/lib/gems/1.9.1/bin:$PATH
export PATH=/usr/lib/postgresql/8.4/bin:$PATH
export CDPATH=.:$HOME/src

export EDITOR="emacsclient"

export DEBEMAIL="technomancy@gmail.com"
export DEBFULLNAME="Phil Hagelberg"
