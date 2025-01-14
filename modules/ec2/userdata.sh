#!/bin/bash
sudo apt update -y
sudo apt upgrade -y

#Install Jenkins
sudo apt install fontconfig openjdk-17-jre -y
java -version
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

#Install Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install docker-ce -y
sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins
groups jenkins
sudo chown root:docker /var/run/docker.sock
sudo chmod 660 /var/run/docker.sock
sudo systemctl restart jenkins
sudo systemctl start docker
sudo systemctl enable docker

#Install zip 
sudo apt update
sudo apt install zip -y



