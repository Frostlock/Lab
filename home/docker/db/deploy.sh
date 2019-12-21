#!/usr/bin/env bash
# To overwrite local changes uncomment the next line
#git reset --hard origin/master

#No custom container yet so no need to build it :)
#git pull
#docker build -t db .
docker-compose up -d
