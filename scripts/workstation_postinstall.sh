####################################
# WORKSTATION CONFIGURATION SCRIPT #
####################################
# Update the system
sudo apt-get update
sudo apt-get upgrade -y -q
# Set timezone
# timedatectl list-timezones
sudo timedatectl set-timezone Europe/Brussels

##################
# REMOTE DESKTOP #
##################
# Install XFCE desktop environment and launch it via .xsession
sudo apt-get install xfce4 -y -q
echo xfce4-session >~/.xsession
# Optional: install some extra software packages
sudo apt-get install xfce4-terminal, mousepad -y -q

# You can replace the above by the following if you prefer LXDE
# Install LXDE desktop environment and launch it via .xsession
#sudo apt-get install lxde -y -q
#echo "exec startlxde" >~/.xsession

# Install the rdp server
sudo apt-get install xrdp -y -q
# Restart the rdp server
sudo service xrdp restart

##################
# EXTRA SOFTWARE #
##################
# Pycharm
#sudo apt-get install default-jre -y -q
#sudo snap install pycharm-community --classic
# Firefox browser
#sudo apt-get install firefox -y -q
# Chrome browser (https://www.ubuntuupdates.org/ppa/google_chrome)
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable -y -q
# Baobab disk analyzer
sudo apt-get install baobab
# Text editor
sudo apt-get install nano
