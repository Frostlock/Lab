#!/usr/bin/env bash
#
# This script creates a new docker engine host in LXD
# It requires a LXD bridge profile to be correctly configured.
# (We want the new docker host to appear on the local network)
# You can opt deploy different host Operating Systems
# Available images can be checked with the following command
# lxc image list images:ubuntu


# Parameters
LXD_PROFILE=bridgeprofile
LXD_IMAGE=images:ubuntu/xenial/amd64
HOST=docker
TOKEN_PATH=~/duplicacy-google-token.json
DUPLICACY=duplicacy_linux_x64_2.2.3

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

# Initialize a new docker host
echo -e "\e[32m---> Initializing new docker host: $HOST \e[39m";
lxc init $LXD_IMAGE $HOST;
lxc profile assign $HOST $LXD_PROFILE;

# Set some parameters on the container
lxc config set $HOST security.nesting true;
lxc config set $HOST limits.memory 4GB;
lxc config set $HOST limits.cpu 1;

# Start the new host
echo -e "\e[32m---> Starting new docker host: $HOST \e[39m";
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
echo -e "\e[32m---> Upgrading new docker host: $HOST \e[39m";
lxc exec $HOST -- sh -c " \
  apt-get -qq update; \
  apt-get -qq -y upgrade; \
  apt-get -qq -y install wget nano; \
";

# Install docker-ce from repositories
# https://docs.docker.com/install/linux/docker-ce/ubuntu/
echo -e "\e[32m---> Installing docker pre-reqs. \e[39m";
lxc exec $HOST -- sh -c "apt-get -qq -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common";
echo -e "\e[32m---> Adding docker repo key \e[39m";
lxc exec $HOST -- sh -c "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -";
echo -e "\e[32m---> Adding docker repositories \e[39m";
lxc exec $HOST -- sh -c "add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"";
echo -e "\e[32m---> Installing docker \e[39m";
lxc exec $HOST -- sh -c "apt-get -qq update";
lxc exec $HOST -- sh -c "apt-get -qq -y install docker-ce docker-ce-cli containerd.io";
echo -e "\e[32m---> Wait for docker daemon to activate properly... \e[39m";
sleep 5;
echo -e "\e[32m---> Testing docker \e[39m";
lxc exec $HOST -- sh -c "docker run hello-world";

# Download duplicacy binary, don't rename it :)
# https://forum.duplicacy.com/t/restore-to-a-different-folder-or-computer/1103
echo -e "\e[32m---> Downloading duplicacy binary $DUPLICACY \e[39m";
lxc exec $HOST -- sh -c " \
  wget https://github.com/gilbertchen/duplicacy/releases/download/v2.2.3/$DUPLICACY; \
  chmod u+x $DUPLICACY; \
  mv ./$DUPLICACY /bin; \
";

echo -e "\e[32m---> Prepare Google drive access token from $TOKEN_PATH to $HOST \e[39m";
lxc file push $TOKEN_PATH $HOST/;

#echo -e "\e[32m---> Connecting duplicacy to Google drive \e[39m";
#lxc exec $HOST -- sh -c ' \
#  cd /var/lib/docker/volumes/; \
#  echo /duplicacy-google-token.json | duplicacy_linux_x64_2.2.3 init DockerVolumeBackup gcd://duplicacy; \
#';
#
#echo -e "\e[32m---> Retrieving available revisions \e[39m";
#lxc exec $HOST -- sh -c ' \
#  cd /var/lib/docker/volumes/; \
#  echo /duplicacy-google-token.json | duplicacy_linux_x64_2.2.3 list > revisions.txt; \
#';
#
#echo -e "\e[32m---> Executing restore of latest revision, this might take a while... \e[39m";
#lxc exec $HOST -- sh -c ' \
#  cd /var/lib/docker/volumes/; \
#  REV=`tail -n 1 revisions.txt | awk '"'"'{print $4}'"'"'`; \
#  echo "\e[32m---> Restoring revision $REV \e[39m"; \
#  echo /duplicacy-google-token.json | duplicacy_linux_x64_2.2.3 restore -r $REV -overwrite; \
#' > restore.log;
#echo "      Restore log available in ./restore.log";
#
#echo -e "\e[32m---> Clean up duplicacy artifacts on $HOST \e[39m";
#lxc exec $HOST -- sh -c ' \
#  rm /duplicacy-google-token.json; \
#  rm /var/lib/docker/volumes/revisions.txt; \
#  rm -r /var/lib/docker/volumes/.duplicacy; \
#';
#
#echo -e "\e[32m---> Restart Docker Daemon \e[39m";
#lxc exec $HOST -- sh -c "systemctl restart docker";
#
#echo -e "\e[32m---> Install Docker compose \e[39m";
#lxc exec $HOST -- sh -c ' \
#sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; \
#sudo chmod +x /usr/local/bin/docker-compose; \
#';
#
#echo -e "\e[32m---> Cloning git repository\e[39m";
#lxc exec $HOST -- sh -c ' \
#  git clone https://github.com/Frostlock/Lab.git;
#';
#
#echo -e "\e[32m---> Running docker-compose, this might take a while... \e[39m";
#lxc exec $HOST -- sh -c ' \
#  cd Lab/home/docker/pi; \
#  docker-compose up -d; \
#  cd ../mydash;
#  ./deploy.sh; \
#';
#
#echo -e "\e[32m---> Script finished, $HOST up and running :) \e[39m";