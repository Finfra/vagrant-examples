## Virtualbox
export DEBIAN_FRONTEND=noninteractive
apt update -y
apt-get install -y virtualbox
usermod -a -G disk vagrant
usermod -a -G vboxusers vagrant
vboxmanage setproperty machinefolder /home/vagrant/VirtualboxVms
apt-get install virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
apt install -yq vagrant
vagrant --version
reboot


