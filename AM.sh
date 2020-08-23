#!/usr/bin/env bash

timedatectl set-ntp true

mkfs.vfat -F32 /dev/sda5
mkfs.ext4 /dev/sda6

mount /dev/sda6 /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda5 /mnt/boot/efi

pacstrap /mnt base base-devel linux linux-firmware vim

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
