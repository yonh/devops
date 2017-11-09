#!/bin/bash

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# sudo usermod -aG docker `whoami`





# install gogs
sudo docker pull gogs/gogs
sudo docker pull jenkins/jenkins:2.72
sudo docker pull maven:3.5.0-jdk-8-alpine
sudo docker pull mysql/mysql-server:5.7
