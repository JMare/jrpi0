#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
	grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
		sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

cp board/raspberrypi/S41i2c ${TARGET_DIR}/etc/init.d/S41i2c
cp package/busybox/S10mdev ${TARGET_DIR}/etc/init.d/S10mdev
chmod 755 ${TARGET_DIR}/etc/init.d/S10mdev
cp package/busybox/mdev.conf ${TARGET_DIR}/etc/mdev.conf
 
cp board/raspberrypi/interfaces ${TARGET_DIR}/etc/network/interfaces
cp board/raspberrypi/wpa_supplicant.conf ${TARGET_DIR}/etc/wpa_supplicant.conf
cp board/raspberrypi/sshd_config ${TARGET_DIR}/etc/ssh/sshd_config

cp board/raspberrypi/S99app ${TARGET_DIR}/etc/init.d/S99App
cp board/raspberrypi/app.py ${TARGET_DIR}/bin/app.py

if [ ! -z $(grep "/dev/mmcblk0p3" ${TARGET_DIR}/etc/fstab) ];
then echo "Fstab already modified";
else
	echo "Modifying Fstab";
	cat board/raspberrypi/massstoragefstab.frag >> ${TARGET_DIR}/etc/fstab;
fi
