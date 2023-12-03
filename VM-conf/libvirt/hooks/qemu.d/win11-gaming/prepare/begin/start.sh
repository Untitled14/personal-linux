#!/bin/bash
# Helpful to read output when debugging
set -x

# Stop display manager
systemctl stop gdm.service
## Uncomment the following line if you use GDM

sleep 1

killall gdm-x-session

# Unbind VTconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# Unbind EFI-Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# Avoid a Race condition by waiting 2 seconds. This can be calibrated to be shorter or longer if required for your system
sleep 2

rmmod nvidia_uvm
rmmod nvidia_drm
rmmod nvidia_modeset
rmmod nvidia

# Unbind the GPU from display driver
virsh nodedev-detach pci_0000_07_00_0
virsh nodedev-detach pci_0000_07_00_1
virsh nodedev-detach pci_0000_07_00_2
virsh nodedev-detach pci_0000_07_00_3

## Load VFIO-PCI driver ##
modprobe vfio
modprobe vfio_pci
modprobe vfio_iommu_type1

