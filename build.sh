#!/bin/sh

rm -rf kernel.zip
rm -rf ramdisk.gz
find -name "*~" -exec rm -rf {} \;

cd boot.img-ramdisk
find . | cpio -o -H newc | gzip > ../ramdisk.gz
cd ..
./mkbootimg --kernel zImage --ramdisk ramdisk.gz --base 0x80600000 --ramdisk_offset 0x01400000 --pagesize 2048 --cmdline "console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31" -o boot.img

mv -v boot.img out/
cd out
adb push boot.img /sdcard/romswitcher/second.img
zip -r kernel.zip META-INF boot.img
mv -v kernel.zip ../
cd ..
