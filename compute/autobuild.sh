#! /bin/bash

builddir="/tmp/tmp-"`date +%s`
mkdir -p $builddir
cd $builddir

# build kimchi
git clone https://github.com/litevirt/kimchi.git
cd kimchi
git checkout openstack
./autogen.sh --system
make
make rpm

# create local repo for kimchi
if [ -d /root/rpm/RPMS/x86_64/ ];then
    rm -rf /root/rpm/RPMS/x86_64
fi
mkdir -p /root/rpm/RPMS/x86_64
cp -rf rpm/RPMS/x86_64/kimchi*.rpm /root/rpm/RPMS/x86_64/
createrepo /root/rpm/RPMS/x86_64/ --update

# build ovirt-node
cd ..
git clone https://github.com/litevirt/ovirt-node.git
cd ovirt-node
git checkout openstack

# generate iso
./autobuild.sh

