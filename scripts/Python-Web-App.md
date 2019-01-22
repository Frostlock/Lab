# Based on
# https://docs.microsoft.com/en-us/azure/app-service/containers/quickstart-python?toc=%2Fpython%2Fazure%2FTOC.json
# More information on the configuration
# https://docs.microsoft.com/en-us/azure/app-service/containers/how-to-configure-python

# This will create a new Linux Web App
# Code for the app is pulled from a public github repo into a local gir repo on the cloudshell
# From the cloudshell it is pushed in to the deployment git
# Code below is for Azure Bash CLI

# Create user and password for deployments
az webapp deployment user set --user-name pboogaerts --password XXXXXXXXX

# Set up the app service plan and create the web application
az group create --name webapp --location "West Europe"
az appservice plan create --name LinuxAppServicePlan --resource-group webapp --sku B1 --is-linux --location "West Europe"
# appname should be globally unique
az webapp create --resource-group webapp --plan LinuxAppServicePlan --name pboogaerts --runtime "PYTHON|3.7" --deployment-local-git
# This will output a git deploy URL, in my case: 
# https://pboogaerts@pboogaerts.scm.azurewebsites.net/pboogaerts.git

#Deploy some code
git clone https://github.com/Azure-Samples/python-docs-hello-world
cd python-docs-hello-world
git remote add azure https://pboogaerts@pboogaerts.scm.azurewebsites.net/pboogaerts.git
git push azure master

# A short while later the webapp will be running
