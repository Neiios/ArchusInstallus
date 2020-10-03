#!/usr/bin/env bash

#bootctl install
#cat <<EOF > /boot/loader/entries/arch.conf
#title Arch Linux  
#linux /vmlinuz-linux  
#initrd  /initramfs-linux.img  
#options root=/dev/sda6 rw
#EOF

ln -sf /usr/share/zoneinfo/Europe/Vilnius /etc/localtime
hwclock --systohc

sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

echo Summit > /etc/hostname
echo 127.0.1.1 localhost.localdomain Summit > /etc/hosts

pacman -S networkmanager dhclient --noconfirm --needed
systemctl enable --now NetworkManager

passwd root

pacman -S grub efibootmgr os-prober ntfs-3g --noconfirm --needed
mkdir /boot/efi
mount /dev/sda5 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable
grub-mkconfig -o /boot/grub/grub.cfg

useradd -m -g users -G wheel -s /bin/bash neiios
passwd neiios

sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/locale.gen
pacman -S pulseaudio pulseaudio-alsa xorg xorg-xinit xorg-server --noconfirm --needed

echo "--------------------------------------"
echo "--   SYSTEM READY FOR FIRST BOOT    --"
echo "--------------------------------------"

exit
