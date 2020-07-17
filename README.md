# Technomancy Dotfiles

Moved to [Sourcehut](https://git.sr.ht/~technomancy/dotfiles)

Everything it takes to run a technomancy-approved system.

## Basics

Designed to run on [Debian](http://debian.org) systems; would probably
work with [Ubuntu](http://ubuntu.com) too.

## Init

Installation and bootstrapping of dotfiles is handled by the
`bin/init/go.sh` script. This script should be idempotent.

## Emacs

Some Emacs packages are installed thru apt and some vendored in
`.emacs.d/lib`. Use `M-x pnh-reinit-libs` to byte-compile and autoload
the vendored ones.

## Usage

I use [EXWM](https://technomancy.us/185) because ... it's the best?
