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

sudo docker run -d --name mysql \
 -p 3306:3306 \
 -e MYSQL_USER=sonar \
 -e MYSQL_PASSWORD=sonar \
 -e MYSQL_DATABASE=sonar \
 -e MYSQL_RANDOM_ROOT_PASSWORD=true \
 --restart=always \
 -v /tmp/mysql_data:/var/lib/mysql \
 mysql/mysql-server:5.7

MYSQL_IP="0.0.0.0"

sudo docker run -d --name sonarqube \
 -p 9000:9000 \
 -p 9092:9092 \
 -e SONARQUBE_JDBC_USERNAME=sonar \
 -e SONARQUBE_JDBC_PASSWORD=sonar \
 -e SONARQUBE_JDBC_URL="jdbc:mysql://${MYSQL_IP}:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true" \
 --restart=always \
 sonarqube:6.4-alpine
# default password admin / admin
