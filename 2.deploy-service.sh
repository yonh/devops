#!/bin/bash

if [ ! -d "workspace" ]; then
	mkdir workspace
fi

cd workspace

sudo docker run -dt --name=gogs \
 -p 10022:22 \
 -p 3000:3000 \
 --restart=always \
 -v $PWD/gogs_data:/data \
 gogs/gogs

sudo docker run -d --name jenkins \
 -p 8080:8080 \
 -p 10000:10000 \
 -p 50000:50000 \
 -v $PWD/jenkins_data:/var/jenkins_home \
 -v /usr/bin/docker:/usr/bin/docker \
 -v /var/run/docker.sock:/var/run/docker.sock \
 -v /usr/lib/x86_64-linux-gnu/libltdl.so.7:/usr/lib/x86_64-linux-gnu/libltdl.so.7 \
 --restart=always \
 --user root \
 jenkins/jenkins:2.72

