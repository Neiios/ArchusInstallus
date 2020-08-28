pacman -S networkmanager dhclient efibootmgr os-prober ntfs-3g dosfstools --noconfirm --needed
systemctl enable --now NetworkManager

passwd root

bootctl install
cat <<EOF > /boot/loader/entries/arch.conf
title Arch Linux  
linux /vmlinuz-linux  
initrd  /initramfs-linux.img  
options root=/dev/sda6 rw
EOF

exit
umount -R /mnt

echo "--------------------------------------"
echo "--   SYSTEM READY FOR FIRST BOOT    --"
echo "--------------------------------------"
