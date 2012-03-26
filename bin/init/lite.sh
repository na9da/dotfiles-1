#!/bin/bash

# Bootstrap a smaller set of dotfiles; should be more cross-platform.

set -e

dotfiles_raw=https://github.com/technomancy/dotfiles/raw/master

if type -p curl >/dev/null 2>&1; then
    HTTP_CLIENT="curl -f -L -o"
else
    HTTP_CLIENT="wget -O"
fi

mkdir -p ~/.emacs.d
$HTTP_CLIENT ~/.emacs.d/init.el $dotfiles_raw/.emacs.d/init-lite.el

files=".bashrc .bash_aliases .profile .tmux.conf"

cd ~
for f in $files; do
    $HTTP_CLIENT $f $dotfiles_raw/$f
done

git config --global user.name "Phil Hagelberg"
git config --global user.email "technomancy@gmail.com"

# run as user
# grab elisp packages
emacs --batch -l .emacs.d/init.el -f kill-emacs

source ~/.bashrc
sourec ~/.profile

# not being honored
export TERM=xterm-256color

which tmux-shared && tmux-shared
