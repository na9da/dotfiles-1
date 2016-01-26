#!/bin/bash

set -e

if [ "$USER" = "root" ]; then
    echo "can't run as root"
    exit 1
fi

firefox -CreateProfile main
firefox -CreateProfile proxied

rm -f ~/.ff ~/.ff-proxied

mkdir -p ~/src
ln -s ~/.mozilla/firefox/*main/ ~/.ff
ln -s ~/.mozilla/firefox/*proxied/ ~/.ff-proxied
rm -f ~/.ff/user.js ~/.ff-proxied/user.js
ln -s ~/.dotfiles/.ff.js ~/.ff/user.js
ln -s ~/.dotfiles/.ff-proxied.js ~/.ff/user.js

cd /tmp

wget https://github.com/mooz/keysnail/raw/master/keysnail.xpi
wget https://www.eff.org/files/privacy-badger-latest.xpi
wget https://www.eff.org/files/https-everywhere-latest.xpi
wget -O noscript.xpi https://addons.mozilla.org/en-US/firefox/downloads/latest/722/addon-722-latest.xpi?src=noscript.ownsite
wget -O stylish.xpi https://addons.mozilla.org/firefox/downloads/latest/2108/addon-2108-latest.xpi?src=external-installbox

firefox -P main /tmp/keysnail.xpi
firefox -P main /tmp/privacy-badger-latest.xpi
firefox -P main /tmp/https-everywhere-latest.xpi
firefox -P main /tmp/noscript.xpi
firefox -P main /tmp/stylish.xpi

# firefox -P proxied /tmp/keysnail.xpi
# firefox -P proxied /tmp/privacy-badger-latest.xpi
# firefox -P proxied /tmp/https-everywhere-latest.xpi
# firefox -P proxied /tmp/noscript.xpi
