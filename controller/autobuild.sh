#! /bin/bash

# compile init rpm
cp -f -r ConInit ConInit-0.1
tar -cvf ConInit-0.1.tar ConInit-0.1
mv -f ConInit-0.1.tar /root/rpmbuild/SOURCES/
rm -f -r ConInit-0.1
rpmbuild -ba ./ConInit/ConInit.spec


# create local repo
if [ -d /root/rpm/RPMS/x86_64/ ];then
    rm -rf /root/rpm/RPMS/x86_64
fi
mkdir -p /root/rpm/RPMS/x86_64
mv -f /root/rpmbuild/RPMS/noarch/ConInit*.rpm /root/rpm/RPMS/x86_64/
createrepo /root/rpm/RPMS/x86_64/ --update


livecd-creator --config=openstack-controller-node.ks \
				--fslabel=Openstack-Controller \
				--cache=/var/cache/live

