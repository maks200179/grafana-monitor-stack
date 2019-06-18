#!/bin/bash

set -x

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)


docker volume prune 
docker system prune 
docker image prune
 

#docker rmi $(docker images -q)


systemctl stop docker
#rm -rf /var/lib/docker/overlay2/*
systemctl start  docker 


