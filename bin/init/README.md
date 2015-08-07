# Technomancy Init

For fresh installs on Debian or Ubuntu.

    $ wget j.mp/tech-init && sudo bash tech-init

On Debian systems do this first:

    $ su
    $ apt-get install sudo
    $ usermod -G sudo phil

This determines whether to pull in the full set of packages based on
the `$DISPLAY` variable, so set it to a nonsense value if you're
installing from the shell but you still want a GUI.

# Browsery stuff

Automating the installation of Firefox plugins is a complete
nightmare. Some ore available via apt-get, but some are only practical
to install by hand:

* privacy badger https://eff.org/pb
* keysnail https://github.com/mooz/keysnail/wiki/plugin
