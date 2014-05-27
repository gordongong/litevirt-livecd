Controller node
===============

#### build iso
1. git clone litevirt-livecd
2. cd controller  
3. sh -x autobuild.sh   

#### install iso
1. boot machine with the iso you build   
2. bos-install --drive install_device(such as "/dev/sda")

### Init the openstack controller
1. bos_init \<controller_ipaddr\> \<prefix\> \<gateway\>

