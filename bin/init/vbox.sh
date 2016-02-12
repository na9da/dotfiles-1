sudo apt-get install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') virtualbox

sudo modprobe vboxdrv

VBoxManage setproperty machinefolder $HOME/.vbox-vms # you toolbag.
