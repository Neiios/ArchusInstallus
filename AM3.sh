#!/usr/bin/env bash

ln -sf /usr/share/zoneinfo/Europe/Vilnius /etc/localtime
hwclock --systohc

sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

echo Summit > /etc/hostname
echo 127.0.1.1 localhost.localdomain Summit > /etc/hosts

useradd -m -G wheel neiios

sed -i 's/^# %wheel ALL=(ALL) ALL NOPASSWD: ALL/%wheel ALL=(ALL) ALL NOPASSWD: ALL/' /etc/sudoers.tmp

pacman -S pulseaudio pulseaudio-alsa xorg xorg-xinit xorg-server xfce4 lightdm lightdm-gtk-greeter firefox
echo "exec startxfce4" > ~/.xinitrc
systemctl enable lightdm
