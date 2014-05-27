#!/usr/bin/env bash
STACK_TEMPLATE="/etc/template/db"
ROOT_PASSWORD="admin"
HOST_OLD_IP="192.168.1.104"
HOST_NEW_IP=$1

service mysqld restart
chkconfig mysqld on
mysqladmin -u root password ${ROOT_PASSWORD}

#clean database
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "DROP DATABASE neutron_ml2;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "DROP DATABASE glance;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "DROP DATABASE heat;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "DROP DATABASE keystone;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "DROP DATABASE cinder;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "DROP DATABASE nova;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "DROP DATABASE mysql;"

#create database
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "CREATE DATABASE mysql;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "CREATE DATABASE neutron_ml2;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "CREATE DATABASE glance;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "CREATE DATABASE heat;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "CREATE DATABASE keystone;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "CREATE DATABASE cinder;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "CREATE DATABASE nova;"


#import openstak database
mysql -u root -p${ROOT_PASSWORD} mysql     < ${STACK_TEMPLATE}/mysql.sql
mysql -u root -p${ROOT_PASSWORD} cinder    < ${STACK_TEMPLATE}/cinder.sql
mysql -u root -p${ROOT_PASSWORD} glance    < ${STACK_TEMPLATE}/glance.sql
mysql -u root -p${ROOT_PASSWORD} heat      < ${STACK_TEMPLATE}/heat.sql
cp ${STACK_TEMPLATE}/keystone.sql ${STACK_TEMPLATE}/keystone_work.sql
sed  -i "s/${HOST_OLD_IP}/${HOST_NEW_IP}/g"  ${STACK_TEMPLATE}/keystone_work.sql
mysql -u root -p${ROOT_PASSWORD} keystone  < ${STACK_TEMPLATE}/keystone_work.sql
rm -f -r ${STACK_TEMPLATE}/keystone_work.sql
mysql -u root -p${ROOT_PASSWORD} neutron_ml2   < ${STACK_TEMPLATE}/neutron_ml2.sql
mysql -u root -p${ROOT_PASSWORD} nova      < ${STACK_TEMPLATE}/nova.sql

#truncate tables
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "TRUNCATE TABLE nova.services;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "TRUNCATE TABLE cinder.services;"
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "TRUNCATE TABLE neutron_ml2.agents;"

#remove_anonymous_users
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "DELETE FROM mysql.user WHERE User='';"
#remove_remote_root
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
#remove_test_database
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "DROP DATABASE test;DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
#reload_privilege_tables
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "FLUSH PRIVILEGES;"

#truncate table compute_nodes in nova
mysql -uroot -p$ROOT_PASSWORD -h127.0.0.1 -e "TRUNCATE table nova.compute_nodes;"


service mysqld restart

