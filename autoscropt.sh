#!/bin/bash

sgdisk --zap-all /dev/sda

## Partition the disks
# Replace /dev/sda (lsblk)

# Boot partition (1 GiB)
parted /dev/sda mklabel gpt mkpart boot fat32 1MiB 1024MiB
parted /dev/sda set 1 esp on

# Swap partition (36 GiB)
parted /dev/sda mkpart swap linux-swap 1024MiB 2GiB 

# Root partition (128 GiB)
parted /dev/sda mkpart root ext4 2GiB 20GiB

# Home partition (Remaining space)
parted /dev/sda mkpart home ext4 20GiB 100% 
