#!/bin/bash

$PROJECTNAME="jdoe"
$DIR="/var/www"
$PWD=""
cd $DIR
mkdir $PROJECTNAME
cd $PROJECTNAME


wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
mv wordpress/* ./
rmdir ./wordpress/
rm -f latest.tar.gz


#TODO: command MYSQL
CREATE USER '${PROJECTNAME}'@'%' IDENTIFIED BY '${PWD}';
GRANT USAGE ON *.* TO 'clt_${PROJECTNAME}'@'%' IDENTIFIED BY '${PWD}' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;CREATE DATABASE IF NOT EXISTS `clt_politikfranc`;GRANT ALL PRIVILEGES ON `clt\_${PROJECTNAME}`.* TO 'clt_${PROJECTNAME}'@'%';

chmod 755 -R $DIR
chown www-data:www-data -R $DIR

#TODO: Send info mail
