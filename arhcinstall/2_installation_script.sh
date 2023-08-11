#!/bin/bash

mount --mkdir /dev/sda1 /mnt/boot 
mount /dev/sda3 /mnt
mount --mkdir /dev/sda4 /mnt/home
# mount --mkdir /dev/sdb1 /mnt/home

sudo pacman -Sy pacman-contrib

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
rankmirrors -n 10 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

pacstrap -K /mnt base linux linux-firmware base-devel

genfstab -U -p /mnt >> /mnt/etc/fstab