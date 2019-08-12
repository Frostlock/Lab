###########################################
# Script to install google drie ocamlfuse # 
###########################################

# Installation
sudo add-apt-repository ppa:alessandro-strada/ppa;
sudo apt-get update;
sudo apt-get install google-drive-ocamlfuse;

# Usage
## First time run
# google-drive-ocamlfuse
## On a headless system:
# https://github.com/astrada/google-drive-ocamlfuse/wiki/Headless-Usage-&-Authorization
## Mount the filesystem
# google-drive-ocamlfuse mountpoint
## To unmount
#fusermount -u mountpoint
