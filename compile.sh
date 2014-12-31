#!/bin/bash

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

clear
echo "Ready to start adb."
echo "Please connect Tablet and make sure debuging is enabled"
echo "Press Enter when ready"
read
sudo adb shell

echo "Ready to start tablet into bootloader mode."
echo "Please connect Tablet and make sure debuging is enabled"
echo "Press Enter when ready"
read
sudo adb reboot bootloader
echo "Rebooting Tablet into Bootloader mode"

sleep 10
cd ../
echo "Ready to flash clockworkmod."
echo "Press Enter when ready"
read
sudo heimdall flash --RECOVERY recovery.img

echo "tablet rebooting..."
sleep 20
echo "Rebooting tablet into recovery..."
sudo adb reboot recovery

sleep 15
echo "Connecting to tablet through adb..."
sudo adb shell


