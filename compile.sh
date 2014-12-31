#!/bin/bash

if [ $1 = "auto" ];then read="continuing";else read="read";fi

if [ $1 != "fast" ]
then 
  read="read"

  echo "Installing needed files to compile and Android adb tools"
  sudo apt-get update
  sudo apt-get install build-essential pkg-config zlib1g-dev libusb-dev libqt4-dev qt4-qmake autoconf libtool libusb-1.0-0-dev automake android-tools-adb abootimg -y
  
  cd ./libpit
  ./autogen.sh
  ./configure
  make
  cd ../heimdall
  ./autogen.sh
  ./configure
  make
  sudo make install
  cd ../
else
  read="echo 'continuing'"
fi

clear
echo "Ready to start adb."
echo "Please connect Tablet and make sure debuging is enabled"
echo "Press Enter when ready"
$read
sudo adb shell

echo "Ready to start tablet into bootloader mode."
echo "Please connect Tablet and make sure debuging is enabled"
echo "Press Enter when ready"
$read
sudo adb reboot bootloader
echo "Rebooting Tablet into Bootloader mode"

sleep 10
echo "Ready to flash clockworkmod."
echo "Press Enter when ready"
$read
sudo heimdall flash --RECOVERY recovery.img

echo "tablet rebooting..."
sleep 20
echo "Rebooting tablet into recovery..."
sudo adb reboot recovery

sleep 15
echo "mounting partitions..."
sudo adb shell "rm /sdcard"
sudo adb shell "mkdir /sdcard"
sudo adb shell "parted /dev/block/mmcblk0 print"
sudo adb shell "mount /dev/block/mmcblk0p23 /system"
sudo adb shell "mount /dev/block/mmcblk0p24 /cache"

echo """
To mount user data and sdcard use these commands:
mount /dev/block/mmcblk1p1 /sdcard
mount /dev/block/mmcblk0p26 /data
"""
echo "Connecting to tablet through adb..."
sudo adb shell
