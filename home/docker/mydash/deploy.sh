#!/usr/bin/env bash
git pull
docker build -t mydash .
docker-compose up -d