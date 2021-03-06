#!/bin/bash

echo "Cleanup unused pre build..."
rm -f kernel.zip
rm -f ramdisk.gz
rm -f out/boot.img
find -name "*~" -exec rm -f {} \;

echo "Building ramdisk and packaging kernel..."
cd boot.img-ramdisk
find . | cpio -o -H newc | gzip > ../ramdisk.gz
cd ..
./mkbootimg --kernel zImage --ramdisk ramdisk.gz --base 0x80600000 --ramdisk_offset 0x01400000 --cmdline "console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31" -o boot.img

echo "Building flashable kernel.zip and copying boot.img to romswitcher folder.."
adb push boot.img /sdcard/romswitcher/second.img
mv -v boot.img out/
cd out
zip -r kernel.zip META-INF boot.img
mv -v kernel.zip ../
cd ..
