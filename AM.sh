#!/usr/bin/env bash

timedatectl set-ntp true

pacman -Sy

#Making partitions.
sgdisk -n 1:0:+512M /dev/sda
sgdisk -n 2:0:0     /dev/sda

sgdisk -t 1:ef00 /dev/sda
sgdisk -t 2:8300 /dev/sda

#Formatting drive.
mkfs.vfat -F32 /dev/sda1
mkfs.ext4 -F /dev/sda2

#Mounting created partitions.
mount /dev/sda2 /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

pacstrap /mnt base base-devel linux linux-firmware vim

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

pacman -S network-manager dhclient --noconfirm --needed
systemctl enable --now NetworkManager

echo "Enter root password"
passwd root

exit
umount -R /mnt
