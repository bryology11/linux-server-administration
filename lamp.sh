#!/bin/bash

#to install apache web server
echo "Apache Web Server Installing"
yum install httpd -y

#To start apache web server
echo "Apache server launching"
systemctl start httpd
systemctl enable httpd

#Put permanent ports
echo "Firewall permissions getting ready"
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp

#reload to save config
echo "Reloading the Firewall"
firewall-cmd --reload

#To install PHP
echo "Installing PHP"
yum install php php-mysql -y
yum install php-fpm -y

echo "Apache Server Rebooting"
systemctl restart httpd


echo "<?php phpinfo(); ?>" > /var/www/html/index.php

#Install MariaDB
echo "Installing MariaDB"
yum install mariadb-server mariadb -y
echo "launching MariaDB"
systemctl start mariadb
systemctl enable mariadb

echo "Secure installation processing"
mysql_secure_installation << mdb

y
password
password
y
y
y
y
mdb

