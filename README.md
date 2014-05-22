litevirt-livecd
===============

Based on ovirt-node project, create img of Openstack nodes

1. Install a host with CentOS 6.5(fedora may also be ok but we haven't made too much tests on it by now)

2. Config yum for Openstack and ovirt-node which may need OS, epel, RDO and a customized repo in http://openstack.wiaapp.com/openstack-ovirt-node-deps.
You can config them by yourself, or just run the following commands

   cd compute

   sh installrepo.sh

3. Install some dependent packages for building ovirt-node, kimchi

   sh installdeps.sh

4. Build iso of compute node

   sh autobuild.sh

5. Install iso

   (1) The procedure is the same as installing ovirt-node

   (2) Config static ip, ssh login and host name in configuration page 

6. Config compute node
   
   (1) ssh host
 
   (2) cd /usr/libexec

   (3) sh configcompute.sh --controllerip xx --localip xx

7. Build iso of openstack controller node

   cd controller/autobuild

   sh -x autobuild.sh

8. Install openstack controller node

   login livecd system as root user with no password,

   then execute shell srcipt:

   /usr/sbin/bos-install --drive /dev/sda
