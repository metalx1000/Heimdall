#!/bin/bash

sudo adb shell "mount /dev/block/mmcblk0p23 /system"
sudo adb shell "ln -s /system/bin/busybox /sbin/vi"
echo "cd /system/etc/www/cgi-bin"
sudo adb shell
