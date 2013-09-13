#!/sbin/busybox sh

mkdir -p /1stdata/dual/2nddata
mkdir -p /1stdata/dual/2nddata/app
mount --bind /1stdata/dual/2nddata /data
mount --bind /1stdata/app /data/app

/sbin/busybox mount -t rootfs -o remount,rw rootfs
mount -t tmpfs tmpfs /system/lib/modules

chmod 771 /1stdata
chmod 755 /system
ln -s /lib/modules/* /system/lib/modules/

/sbin/busybox mount -t rootfs -o remount,ro rootfs
