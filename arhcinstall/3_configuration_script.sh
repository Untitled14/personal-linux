#!/bin/bash

# sudo pacman -Syu nano bash-completion
#
# Configure locales
# nano /etc/locale.gen     en_US.UTF-8
# locale-gen
# echo LANG=en_US.UTF-8 > /etc/locale.conf
# export LANG=en_US.UTF-8
#
# nano /etc/pacman.conf
# multilib
# sudo pacman -Sy
#
# passwd
#
# EDITOR=nano visudo
# uncomment wheel
# Defaults rootpw
#
# ip link
# sudo pacman -S dhcpcd networkmanager
# sudo systemctl enable dhcpcd@wlan0.service
# sudo systemctl enable NetworkManager.service

#arch-chroot /mnt

# Change Region/City
ln -sf /usr/share/zoneinfo/Europe/Vilnius /etc/localtime
hwclock --systohc --utc

echo kompiuteris > /etc/hostname

systemctl enable fstrim.timer

useradd -m -g users -G wheel,storage,power -s /bin/bash kestutis
# Enter password
echo "Enter password for kestutis"
passwd kestutis

mount -t efivarfs efivarfs /sys/firmware/efi/efivars/

bootctl install

# Change amd-ucode/intel-ucode. 
sudo pacman -S amd-ucode
echo -e 'title Arch Linux\n'\
'linux /vmlinuz-linux\n'\
'initrd /amd-ucode.img\n'\
'initrd /initramfs-linux.img\n'\
options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/sda3) rw nvidia-drm.modeset=1 > /boot/loader/entries/arch.conf

#Nvidia graphics card
sudo pacman -S linux-headers
sudo pacman -S nvidia-dkms libglvnd nvidia-utils opencl-nvidia lib32-libglvnd lib32-nvidia-utils lib32-opencl-nvidia nvidia-settings

mkdir /etc/pacman.d/hooks
echo -e '[Trigger]\n'\
'Operation=Install\n'\
'Operation=Upgrade\n'\
'Operation=Remove\n'\
'Type=Package\n'\
'Target=nvidia\n'\
'\n'\
'[Action]\n'\
'Depends=mkinitcpio\n'\
'When=PostTransaction\n'\
'Exec=/usr/bin/mkinitcpio -P' > /etc/pacman.d/hooks/nvidia.hook

# nano /etc/mkinitcpio.conf
# MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)


