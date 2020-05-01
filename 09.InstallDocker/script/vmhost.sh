#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
locale-gen ko_KR.UTF-8


### Script for docker env. 
apt-get install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev -y
vagrant plugin install vagrant-libvirt 
vagrant plugin install vagrant-mutate

apt-get  install \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get install docker-ce -y
apt-cache madison docker-ce


#groupadd docker
usermod -aG docker vagrant 
chown -R root:docker /var/run/docker.sock
chmod 777 /var/run/docker.sock
# docker run -it ubuntu

# Docker-compose install
# curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/bin/docker-compose
# chmod 755 /usr/bin/docker-compose

Source="/prj/source/"
mkdir -p $Source

