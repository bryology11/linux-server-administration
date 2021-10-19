#!/bin/bash
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y 
yum install yum-utils -y
yum-config-manager --enable remi-php56 
yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo -y
#to install apache web server
echo "Apache Web Server Installing"
yum install wget rsync -y 
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
echo "#####################################################"
echo "#               Reloading the Firewall              #"
echo "#####################################################"
firewall-cmd --reload

#To install PHP
echo "Installing PHP"
yum install php php-mysql -y
yum install php-fpm -y
yum install php-gd -y 

echo "#####################################################"
echo "#              Installing PHP                       #"
echo "#####################################################"
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

echo "########################################################"
echo "#           MARIADB INSTALLATION COMPLETE!!!           #"
echo "########################################################"

mysql -u root -ppassword << bry
CREATE DATABASE wordpress;
CREATE USER wordpressuser@localhost IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
bry

wget -P /var http://wordpress.org/latest.tar.gz
tar xzvf /var/latest.tar.gz -C /var/
rsync -avP /var/wordpress/ /var/www/html/
mkdir /var/www/html/wp-content/uploads
chown -R apache:apache /var/www/html/*

echo "###########################################################"
echo "#                  INSTALLING WORDPRESS                   #"
echo "###########################################################"


cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i 's/database_name_here/wordpress/' /var/www/html/wp-config.php
sed -i 's/username_here/wordpressuser/' /var/www/html/wp-config.php
sed -i 's/password_here/password/' /var/www/html/wp-config.php

echo "############################################################"
echo "#                      WORDPRESS SETTING UP . . .          #"
echo "############################################################"

systemctl restart httpd

echo "###########################################################"
echo "#               WORDPRESS SUCCESSFULLY INSTALLED!         #"
echo "###########################################################"