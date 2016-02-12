# Technomancy Dotfiles

Everything it takes to run a technomancy-approved system.

## Basics

Designed to run on [Debian](http://debian.org) systems; would probably
work with [Ubuntu](http://ubuntu.com) too. Runs
[XMonad](http://xmonad.org) with a bit of underlying
[GNOME](http://gnome.org) infrastructure doing the low-level stuff
it's good at, like power management, lock screen, nautilus to handle
USB auto-mount, and settings-daemon to set up gpg agent and friends.

Notable additions include:

* [xbindkeys](http://www.nongnu.org/xbindkeys/xbindkeys.html) to
  support defining all desktop-wide keyboard shortcuts in
  s-expressions
* [mpd](http://musicpd.org) to expose music as a service
* [unclutter](http://packages.debian.org/sid/unclutter) to make the
  pointer vanish when irrelevant
* [fbpanel](http://fbpanel.sourceforge.net/) to expose the wifi applet
  and CPU graphs in a dotfiles-friendly, non-intrusive way

All this stuff is launched from the `.xsession` file, which GDM will
show as a session option when logging in.

## Init

Installation and bootstrapping of dotfiles is handled by the
`bin/init/go.sh` script. This script should be idempotent.

## Utilities

For things that need to be accessible outside Emacs, going through
[dmenu](http://tools.suckless.org/dmenu/) is preferred. It's used as a
frontend for queueing music (`music-choose`), opening books
(`dbook.rb`), and connecting to wifi access points (`ery-net`), though
for the latter it's only useful for connecting to known access points
due to a very annoying bug in NetworkManager. (Otherwise we wouldn't
bother to run a panel, but `nm-applet`'s gui is still necessary.)

Displaying output by these scripts is typically done with
`notify-send` in scripts like `music-show` and `notify-battery`.

