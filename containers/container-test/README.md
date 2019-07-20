This folder contains some example code used for a container experiment.
Idea is to build the container image outside of Azure and then upload it into the Azure Container Registry.
Next the container can be started in the Azure Container Service.


Example based on following tutorial
https://runnable.com/docker/python/dockerize-your-flask-application

# Docker build instruction
sudo docker build -t flask-tutorial:latest .

# Docker run instruction
sudo docker run -d -p 8080:8080 flask-tutorial

# Docker stop all 
sudo docker stop $(sudo docker ps -a -q)

# Docker remove all containers
sudo docker rm $(sudo docker ps -a -q)
