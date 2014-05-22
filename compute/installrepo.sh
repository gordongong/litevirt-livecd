#! /bin/bash

wget http://mirrors.163.com/.help/CentOS6-Base-163.repo CentOS6-Base-163.repo
mv CentOS6-Base-163.repo /etc/yum.repos.d/

wget http://ftp.sjtu.edu.cn/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
rm -rf epel-release-6-8.noarch.rpm

yum install -y http://rdo.fedorapeople.org/openstack-icehouse/rdo-release-icehouse.rpm

wget http://openstack.wiaapp.com/download/openstack-ovirt-node-deps.repo openstack-ovirt-node-deps.repo
mv openstack-ovirt-node-deps.repo /etc/yum.repos.d/ 

yum clean all
