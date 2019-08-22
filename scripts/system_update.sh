#######################################################
# Script to update system and add some extra packages #
#######################################################

# Update the system
sudo apt-get update
sudo apt-get upgrade -y -q

# Set timezone
# timedatectl list-timezones
sudo timedatectl set-timezone Europe/Brussels

# Install extra packages
sudo apt-get install wget, curl, mosh
