sudo aptitude install virtualbox-ose virtualbox-ose-dkms linux-headers-amd64

sudo modprobe vboxdrv

VBoxManage setproperty machinefolder $HOME/.vbox-vms # you toolbag.
