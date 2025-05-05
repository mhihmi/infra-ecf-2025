#!/bin/bash
# Package update
sudo yum update -y

# Install Java (Required for Tomcat)
sudo yum install -y java-1.8.0-openjdk

# Download and install Tomcat
cd /opt
sudo curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.tar.gz
sudo tar -xvzf apache-tomcat-9.0.73.tar.gz
sudo mv apache-tomcat-9.0.73 tomcat

# Start Tomcat
sudo chmod +x /opt/tomcat/bin/*.sh
sudo /opt/tomcat/bin/startup.sh

# Setup Tomcat to start on reboot
echo "@reboot root /opt/tomcat/bin/startup.sh" | sudo tee -a /etc/crontab