repo --name=centos6.5-base --baseurl=http://mirrors.163.com/centos/6.5/os/x86_64/
repo --name=centos6.5-update --baseurl=http://mirrors.163.com/centos/6.5/updates/x86_64/
repo --name=epel --baseurl=http://ftp.sjtu.edu.cn/fedora/epel/6/x86_64/
repo --name=rdo-icehouse --baseurl=http://repos.fedorapeople.org/repos/openstack/openstack-icehouse/epel-6/
#repo --name=local --baseurl=file:///root/repo/RPMS
repo --name=local --baseurl=file:///root/rpm/RPMS/x86_64/
repo --name=rdo_customized --baseurl=http://openstack.wiaapp.com/openstack-ovirt-node-deps/
