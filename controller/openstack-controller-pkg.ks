%packages --excludedocs --nobase
#common
openstack-utils
openstack-selinux
rabbitmq-server
mysql-server
MySQL-python

#ceilometer
openstack-ceilometer-common
openstack-ceilometer-api
openstack-ceilometer-collector
openstack-ceilometer-central
openstack-ceilometer-alarm
mongodb
mongodb-server
python-ceilometerclient

#cinder
openstack-cinder
python-cinderclient

#dashboard
openstack-dashboard
memcached
python-memcached
mod_wsgi

#glance
openstack-glance
python-glance

#keystone
openstack-keystone
python-keystone

#neutron
ethtool
openstack-neutron
#openstack-neutron-openvswitch
openstack-neutron-ml2
python-neutronclient

#nova
openstack-nova-api
openstack-nova-cert
openstack-nova-console
openstack-nova-scheduler
openstack-nova-conductor
openstack-nova-novncproxy
python-novaclient

#heat
openstack-heat-api
openstack-heat-api-cfn
openstack-heat-engine

#init
ConInit
ntp

%end
