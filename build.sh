#!/bin/sh

rm -rf kernel.zip
rm -rf ramdisk.gz
find -name "*~" -exec rm -rf {} \;

cd boot.img-ramdisk
find . | cpio -o -H newc | gzip -9 > ../ramdisk.gz
cd ..
./mkbootimg --base 0x80600000 --kernel zImage --ramdisk_offset 0x02000000 --cmdline "console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31" --ramdisk ramdisk.gz -o boot.img

mv -v boot.img out/
cd out
zip -r kernel.zip META-INF boot.img
mv -v kernel.zip ../
cd ..
