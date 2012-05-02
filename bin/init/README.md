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
