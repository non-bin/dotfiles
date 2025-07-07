#!/usr/bin/env bash
# Meant for Debian

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt-get -y update
apt-get -y upgrade
apt-get -y install man sudo neovim fdisk gparted

# static IP:
# sudo vim /etc/network/interfaces

# # The primary network interface
# allow-hotplug enp2s0
# iface enp2s0 inet static
#   address 10.124.0.3
#   netmask 255.255.255.0
#   gateway 10.124.0.1
#   dns-nameservers 1.1.1.1 8.8.8.8

##########
# Docker #
##########
# https://docs.docker.com/engine/install/debian/

# Remove conflicting packages
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt-get -y remove $pkg; done

# Add Docker's official GPG key:
apt-get -y update
apt-get -y install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get -y update

# Install
apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

##########
# Dockge #
##########
# https://github.com/louislam/dockge?tab=readme-ov-file

# Create directories that store your stacks and stores Dockge's stack
mkdir -p /opt/stacks /opt/dockge
cd /opt/dockge

# Download the compose.yaml
curl https://raw.githubusercontent.com/louislam/dockge/master/compose.yaml --output compose.yaml

# Start the server
docker compose up -d

# Finish up

apt-get -y update
apt-get -y upgrade
apt-get -y autoremove
