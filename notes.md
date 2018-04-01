#Docker installation
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
#Post installation
#https://docs.docker.com/install/linux/linux-postinstall/

#Docker uninstall
#sudo apt-get purge docker-ce
#Clean up
#sudo rm -rf /var/lib/docker

#Build the docker image
sudo docker build -t flask-helloworld:latest .
#Run the docker container
sudo docker run -d -p 8080:8080 flask-helloworld
#Takes a while, looks like it might take a few minutes to get all dependencies sorted?