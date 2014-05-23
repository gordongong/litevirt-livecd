build iso
=========
0. git clone litevirt-livecd
1. cd controller  
2. sh -x autobuild.sh   

install iso
===========

1. boot machine with the iso you build   
2. bos-install --drive install_device(such as "/dev/sda")

Init
====
1. cd /etc/template/
2. tar -xvf etc.tar.gz -C /
3. tar -xvf db.tar.gz
4. sh importdb.sh

