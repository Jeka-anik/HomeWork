#!/bin/bash
# Update repositories
sudo apt-get update

# Install NGINX
sudo apt-get install nginx -y

# Configure firewall
# Uncomment out the line that meets your needs
sudo ufw allow 'Nginx Full' # both ports 80 and 443