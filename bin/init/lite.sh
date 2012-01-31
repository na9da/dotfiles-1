#!/bin/bash

dotfiles_raw=https://github.com/technomancy/dotfiles/raw/master

mkdir -p ~/.emacs.d
wget -O ~/.emacs.d/init.el $dotfiles_raw/.emacs.d/init-lite.el

files=".bashrc .bash_aliases .profile .tmux.conf"

cd ~
for f in $files; do
    wget $dotfiles_raw/$f
done

git config --global user.name "Phil Hagelberg"
git config --global user.email "technomancy@gmail.com"
