%include repo.ks
%include openstack-controller-pkg.ks

lang en_US.UTF-8
keyboard us
timezone Asia/Shanghai
auth --useshadow --enablemd5
selinux --disabled
firewall --disabled
part / --size 4096 --fstype ext2
services --enabled="network,sshd"

bootloader --timeout=30 --location=mbr --append="rootflags=ro elevator=deadline rd_NO_LVM max_loop=256" 

device virtio_blk
device virtio_pci
device mptspi
device scsi_wait_scan
device dm-multipath
device dm-round-robin
device dm-emc
device dm-rdac
device dm-hp-sw
device scsi_dh_rdac
device 3w-9xxx
device 3w-sas
device 3w-xxxx
device a100u2w
device aacraid
device aic79xx
device aic94xx
device arcmsr
device atp870u
device be2iscsi
device bfa
device BusLogic
device cciss
device cxgb3i
device dc395x
device fnic
device gdth
device hpsa
device hptiop
device imm
device initio
device ips
device libosd
device libsas
device libsrp
device lpfc
device megaraid
device megaraid_mbox
device megaraid_mm
device megaraid_sas
device mpt2sas
device mvsas
device osd
device osst
device pm8001
device pmcraid
device qla1280
device qla2xxx
device qla4xxx
device qlogicfas408
device stex
device tmscsim
device ums-sddr09
device ums-realtek
device ums-sddr55
device ums-isd200
device ums-alauda
device ums-freecom
device ums-cypress
device ums-jumpshot
device ums-onetouch
device ums-karma
device ums-usbat
device ums-datafab
device ums-eneub6250

%post --nochroot
echo "Add install helper script to livecd"
cp bos-install.py $INSTALL_ROOT/usr/sbin/bos-install
[ -z $FSLABEL ] && FSLABEL=openstack
# Plese be noted double quotes must be used here!!!
sed -i -e "s/<FSLABEL>/$FSLABEL/" $INSTALL_ROOT/usr/sbin/bos-install
chmod +x $INSTALL_ROOT/usr/sbin/bos-install

echo "Fixing boot menu"
cat<<EOF>$LIVE_ROOT/isolinux/isolinux.cfg
default vesamenu.c32
timeout 300
menu background splash.jpg
menu title Welcome to Openstack-Controller!
menu color border 0 #ffffffff #00000000
menu color sel 7 #ffffffff #ff000000
menu color title 0 #ffffffff #00000000
menu color tabmsg 0 #ffffffff #00000000
menu color unsel 0 #ffffffff #00000000
menu color hotsel 0 #ff000000 #ffffffff
menu color hotkey 7 #ffffffff #ff000000
menu color timeout_msg 0 #ffffffff #00000000
menu color timeout 0 #ffffffff #00000000
menu color cmdline 0 #ffffffff #00000000
menu hidden
menu hiddenrow 5
label linux0
  menu label Boot from liveCD
  kernel vmlinuz0
  append initrd=initrd0.img root=live:CDLABEL=Openstack-Controller rootfstype=auto ro liveimg rootflags=ro elevator=deadline rd_NO_LVM max_loop=256 rhgb rd_NO_LUKS rd_NO_MD rd_NO_DM
menu default
label local
  menu label Boot from local drive
  localboot 0xffff
EOF


# remove quiet from Node bootparams, added by livecd-creator
#sed -i -e 's/ quiet//' $LIVE_ROOT/isolinux/isolinux.cfg

# Remove Verify and Boot option
#sed -i -e '/label check0/{N;N;N;d;}' $LIVE_ROOT/isolinux/isolinux.cfg

#place the template files into iso
mkdir -p $INSTALL_ROOT/template
cp -a extlinux.conf $INSTALL_ROOT/template
%end

%post
echo "Starting Kickstart Post"
PATH=/sbin:/usr/sbin:/bin:/usr/bin
export PATH

echo "Refine crond service"
rm -f /etc/cron.daily/logrotate

echo "Strip out all unncesssary locales"
localedef --list-archive | grep -v -i -E 'en_US.utf8' |xargs localedef --delete-from-archive
mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
/usr/sbin/build-locale-archive


echo "Creating shadow files"
# because we aren't installing authconfig, we aren't setting up shadow
# and gshadow properly.  Do it by hand here
pwconv
grpconv

echo "Initalizeing password for root account"
passwd -d root

%end



%packages
aic94xx-firmware
bfa-firmware
db4
device-mapper-multipath
dhclient
dmraid
e2fsprogs
iscsi-initiator-utils
file
hwdata
irqbalance
kernel
acpid
perf
lsof
lsscsi
numactl
openssh-server
openssh-clients
passwd
pciutils
psmisc
python
python-libs
ql2100-firmware
ql2200-firmware
ql23xx-firmware
ql2400-firmware
ql2500-firmware
rootfiles
strace
sudo
sysfsutils
sysstat
tcpdump
usbutils
vim-minimal
bash
ethtool
syslinux
syslinux-extlinux
net-tools
rsyslog
parted
yum
system-config-firewall-base

-audit-libs-python
-authconfig
-libselinux-python
-libuser
-mtools
-newt
-prelink
-setserial
-usermode
-ustr
-dracut
-wireless-tools

%end
