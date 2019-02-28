#!/bin/bash

set -e

if [ "$USER" = "root" ]; then
    echo "can't run as root"
    exit 1
fi

cd /tmp
wget -O /tmp/ff-dev.tar.bz2 "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"

cd ~/bin/
tar -C /tmp xjf /tmp/ff-dev.tar.bz2
mv ~/tmp/firefox ~/bin/firefox-dev-edition

# afaict no way to automate install of these
firefox https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
firefox https://addons.mozilla.org/en-US/firefox/addon/https-everywhere/
firefox https://addons.mozilla.org/en-US/firefox/addon/surfingkeys_ff/

# manually: turn on "hard mode" ublock
