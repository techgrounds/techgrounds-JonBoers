#!/bin/bash

# Set MySQL root password from the parameter
mysqlPassword="myD@t@b@se"

# Update package lists and upgrade packages
sudo apt update
sudo apt upgrade -y

# Install MySQL Server
if sudo apt install -y mysql-server; then
  # Set MySQL root password
  sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$mysqlPassword'; FLUSH PRIVILEGES;"
  echo "MySQL Server installed and root password set successfully."
else
  echo "Failed to install MySQL Server."
  exit 1
fi

# Check the MySQL service status
sudo service mysql status
