pacman -S network-manager dhclient --noconfirm --needed
systemctl enable --now NetworkManager

echo "Enter root password"
passwd root
