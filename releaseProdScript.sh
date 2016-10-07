#!/usr/bin/env bash

#Dameon

# This will break the first time since there won't be a running container. Skip this line the first time!!!
docker build -t myImage . && docker images && docker rm $(docker stop $(docker ps -a -q --filter="name=imageName")) && docker ps &&

docker run --name imageName -d -e PG_DB_URL='jdbc:postgresql://_______:5432/blog' -e PG_DB_PW='_______' -e PG_DB_USER='_______' -p 9000:9000 myImage;
docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi; docker ps;

cat /dev/null > ~/.bash_history; history -cw;
rm releaseProdScript.sh
