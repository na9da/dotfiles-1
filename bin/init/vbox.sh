# Virtualbox, since vagrant doesn't work with the free version
apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -

sudo apt-get install virtualbox-4.1
VBoxManage setproperty machinefolder $HOME/.vbox-vms # you toolbag.
