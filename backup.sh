#!/bin/bash
yum install tar -y
now=$(date +'%m%d%y')
mkdir /opt/backups

mysqldump -u root -ppassword wordpress > /opt/backups/wordpress_$now.sql

cd /opt/backups
tar -zcf wordpress_$now.tar.gz wordpress_$now.sql

echo"##################################################################################"
echo"#                                                                                #"
echo"#                       BACKUP COMPLETED!                                        #"
echo"#                                                                                #"
echo"##################################################################################"