#!/usr/bin/env bash

timedatectl set-ntp true

#sgdisk -Z /dev/sda # zap all on disk
#sgdisk -a 2048 -o /dev/sda # new gpt disk 2048 alignment

#Making partitions.
sgdisk -n 1:0:+512M /dev/sda
sgdisk -n 2:0:0     /dev/sda

sgdisk -t 1:ef00 /dev/sda
sgdisk -t 2:8300 /dev/sda

#Formatting drive.
mkfs.vfat -F32 /dev/sda5
mkfs.ext4 -F /dev/sda6

#Mounting created partitions.
mount /dev/sda6 /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda5 /mnt/boot/efi

pacstrap /mnt base base-devel linux linux-firmware vim --noconfirm --needed
cp AM2.sh /mnt/AM2.sh
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash ./AM2.sh
