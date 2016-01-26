export PATH=$HOME/bin:$HOME/.local/bin:$PATH

if which psql > /dev/null ; then
    export PATH=/usr/lib/postgresql/9.1/bin:$PATH
fi

if which ruby >/dev/null && which gem >/dev/null; then
    export PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

export CDPATH=.:$HOME/src

export XDG_DESKTOP_DIR=$HOME
export XDG_DOWNLOAD_DIR=$HOME
export XDG_DOCUMENTS_DIR=$HOME/docs
export XDG_MUSIC_DIR=$HOME/music

export EDITOR="emacsclient"

export DEBEMAIL="technomancy@gmail.com"
export DEBFULLNAME="Phil Hagelberg"

export PROFILE_LOADED=y # horrible horrible hack

export BUSSARD_RES=1400x800
