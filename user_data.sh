#! /bin/bash

### Install updates ###

sudo yum update -y

# Install Apache server
sudo yum install -y httpd

# Start Apache server and enable it on system startup
sudo systemctl start httpd
sudo systemctl enable httpd