#!/usr/bin/env bash

timedatectl set-ntp true

#sgdisk -Z /dev/sda # zap all on disk
#sgdisk -a 2048 -o /dev/sda # new gpt disk 2048 alignment

#Making partitions.
sgdisk -n 5:0:+512M /dev/sda
sgdisk -n 6:0:0     /dev/sda

sgdisk -t 5:ef00 /dev/sda
sgdisk -t 6:8300 /dev/sda

#Formatting drive.
mkfs.vfat -F32 /dev/sda5
mkfs.ext4 -F /dev/sda6

#Mounting created partitions.
mount -t ext4 /dev/sda6 /mnt
mkdir /mnt/boot
mount -t vfat /dev/sda5 /mnt/boot

pacstrap /mnt base base-devel linux linux-firmware vim --noconfirm --needed
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash ./AM2.sh
