#!/bin/bash -x

##############################################################################
# install tools

sudo dnf -y install make git


##############################################################################
# install python3

sudo dnf install -y python3-pip
sudo pip3 install --upgrade pip
pip3 install wheel


# command "python" is need to build old AWX 
sudo ln -s /usr/bin/python3 /usr/bin/python


##############################################################################
# install docker

sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf -y install docker-ce
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ${USER}

