pacman -S networkmanager dhclient --noconfirm --needed
systemctl enable --now NetworkManager

echo "Enter root password"
passwd root

exit
