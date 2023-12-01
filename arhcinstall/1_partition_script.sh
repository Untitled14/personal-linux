#!/bin/bash

sgdisk --zap-all /dev/sda
sgdisk --zap-all /dev/sdb

## Partition the disks
# Replace /dev/sda (lsblk)

# Boot partition (1 GiB)
parted /dev/sda mklabel gpt mkpart boot fat32 1MiB 1024MiB
parted /dev/sda set 1 esp on

# Swap partition (36 GiB)
parted /dev/sda mkpart swap linux-swap 1024MiB 17GiB

# Root partition (128 GiB)
parted /dev/sda mkpart root ext4 17GiB 128GiB

# Home partition (Remaining space)
parted /dev/sda mkpart home ext4 128GiB 100%
parted /dev/sdb mkpart sdb ext4 1MiB 100% mklabel gpt

# Format the partitions
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
mkfs.ext4 /dev/sdb1

swapon /dev/sda2

echo $'Disk partition done\n\n'

lsblk
