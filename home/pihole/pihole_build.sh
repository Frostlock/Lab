#!/usr/bin/env bash
#
# This script creates a pihole host in LXD
# It requires a LXD bridge profile to be correctly configured.
# (We want the new pihole host to appear on the local network)

# Parameters
LXD_PROFILE=bridgeprofile
LXD_IMAGE=images:ubuntu/bionic/amd64
HOST=pihole

# Old code to have a fixed IP and a variant hostname.
#HOST=build-`date +%Y%m%d-%H%M%S`;
#IP=10.0.0.11
#GATEWAY=10.0.0.1
#DNS=10.0.0.1

#Check for lxd with expected bridgeprofile to exist
echo -e "\e[32m---> Querying lxd for bridgeprofile \e[39m";
if ! lxc profile show $LXD_PROFILE
then
  echo -e "\e[31m---> Failed! The script needs lxd with a profile called $LXD_PROFILE\e[39m";
  exit 1
fi

# Initialize a new pihole host
echo -e "\e[32m---> Initializing new pihole host: \e[39m";
lxc init $LXD_IMAGE $HOST;
lxc profile assign $HOST $LXD_PROFILE;

# Set some parameters on the container
lxc config set $HOST limits.memory 4GB;
lxc config set $HOST limits.cpu 1;

# Start the new host
echo -e "\e[32m---> Starting new pihole host: \e[39m";
lxc start $HOST;
# Sleep for a while to ensure all subsystems are up properly
sleep 5;

# Old code to have a fixed IP and a variant hostname.
## Set static IP
#echo -e "\e[32m---> Applying static IP to $HOST \e[39m";
#lxc exec $HOST -- sh -c " \
#  cd /etc/netplan; \
#  rm *.yaml; \
#  echo \"network:
#    version: 2
#    ethernets:
#      eth0:
#       dhcp4: no
#       addresses: [$IP/24]
#       gateway4: $GATEWAY
#       nameservers:
#         addresses: [$DNS]\" > fixed_ip.yaml; \
#";
#lxc stop $HOST;
#lxc start $HOST;
## Sleep for a while to ensure all subsystems are up properly
#sleep 5;

# Patch the new host
echo -e "\e[32m---> Upgrading new pihole host:\e[39m";
lxc exec $HOST -- sh -c " \
  apt-get -qq update; \
  apt-get -qq -y upgrade; \
  apt-get -qq -y install wget nano git; \
";

# Install pi-hole
echo -e "\e[32m---> Installing pi-hole: \e[39m";
lxc exec $HOST -- sh -c " \
  git clone --depth 1 https://github.com/pi-hole/pi-hole.git Pi-hole; \
  cd 'Pi-hole/automated install/'; \
  sudo bash basic-install.sh; \
";

echo -e "\e[32m---> Script finished, $HOST up and running :) \e[39m";