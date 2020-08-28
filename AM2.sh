pacman -S networkmanager dhclient --noconfirm --needed
systemctl enable --now NetworkManager

passwd root

ln -sf /usr/share/zoneinfo/Europe/Vilnius /etc/localtime
hwclock --systohc

sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

echo Summit > /etc/hostname
echo 127.0.1.1 localhost.localdomain Summit > /etc/hosts



reboot
