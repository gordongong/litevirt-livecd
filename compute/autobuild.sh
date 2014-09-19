#! /bin/bash

if ! options=$(getopt -u -o k,o,d --long kimchi,openstack,docker -- "$@")
then
    # something went wrong, getopt will put out an error message for us
    echo "Usage: sh autobuild.sh --kimchi --openstack"
    exit 1
fi

set -- $options

while [ $# -gt 0 ]
do
    case $1 in
    -k|--kimchi) kimchi="true"; shift;;
    -o|--openstack) openstack="true"; shift;;
    -d|--docker)docker="true"; shift;;
    (--) shift; break;;
    (-*) echo "$0: error - unrecognized option $1" 1>&2; exit 1;;
    (*) break;;
    esac
done

builddir="/tmp/tmp-"`date +%s`
mkdir -p $builddir
cd $builddir

if [ x$kimchi != x ];then
  # build kimchi
  git clone https://github.com/litevirt/kimchi.git
  pushd kimchi
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

  popd
fi

# build ovirt-node
git clone https://github.com/litevirt/ovirt-node.git
cd ovirt-node
git checkout openstack

if [ x$kimchi != x ];then
  echo "%include kimchi/kimchi.ks" >> recipe/ovirt-node-image.ks.in
fi

if [ x$docker != x ];then
  echo "%include docker/docker.ks" >> recipe/ovirt-node-image.ks.in
fi

if [ x$openstack != x ];then
  echo "%include openstack/openstack-common.ks" >> recipe/ovirt-node-image.ks.in
  echo "%include openstack/openstack-compute.ks" >> recipe/ovirt-node-image.ks.in
fi

# generate iso
./autobuild.sh

