# Example with a local git repository
See Python-Web-App.sh

# Github repository
Same approach as in the shell script but instead on the Azure deployment center (in Azure Portal) connect to Github.

# Startup from a github subfolder
To make the webapp run from a github subfolder you need to change the startup instruction.

See documentation here:  
https://code.visualstudio.com/docs/python/tutorial-deploy-app-service-on-linux

In my case the following is needed  
You can put the startup instruction directly in the Azure portal  
``
gunicorn --bind=0.0.0.0 --timeout 600 --chdir webapp-test application:app
``  
Or you can put this instruction in a startup file and then put the path/filename in the Azure portal

One down side is that to make it work I had to keep the requirements.txt in the root of the github repository.
