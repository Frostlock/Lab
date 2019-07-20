#!/usr/bin/env bash
# To overwrite local changes uncomment the next line
#git reset --hard origin/master

git pull
docker build -t mydash .
docker-compose up -d