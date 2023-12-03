#!/bin/bash

reboot

#set -x

#virsh nodedev-reattach pci_0000_07_00_0
#virsh nodedev-reattach pci_0000_07_00_1
#virsh nodedev-reattach pci_0000_07_00_2
#virsh nodedev-reattach pci_0000_07_00_3

#rmmod vfio_pci
#rmmod vfio_iommu_type1
#rmmod vfio

#modprobe nvidia
#modprobe nvidia_modeset
#modprobe nvidia_drm
#modprobe nvidia_uvm

#echo 1 > /sys/class/vtconsole/vtcon0/bind
#echo 1 > /sys/class/vtconsole/vtcon1/bind

#nvidia-xconfig --query-gpu-info > /dev/null 2>&1

#echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

#systemctl start gdm.service

