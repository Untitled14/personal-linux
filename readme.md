

### Enable Wake-on-LAN 
pacman -S ethtool cronie  
EDITOR=nano crontab -e  

`crontab`
```
@reboot ethtool -s <interface> wol g
```


## QEMU virtual machine

Add audio so it doesn't crash
```
<sound model="ich9">
  <codec type="micro"/>
  <audio id="1"/>
  <address type="pci" domain="0x0000" bus="0x00" slot="0x1b" function="0x0"/>
</sound>
<audio id="1" type="pulseaudio" serverName="/run/user/1000/pulse/native"/>
```
### Win11

```
  <cpu mode="host-passthrough" check="none" migratable="on">
    <topology sockets="1" dies="1" cores="8" threads="2"/>
    <feature policy="require" name="topoext"/>
    <feature policy="disable" name="hypervisor"/>
  </cpu>
```
Install `qemu-hw-usb-host` when passing keyboard and mouse
```
sudo pacman -S qemu-hw-usb-host
```

#### GPU-passthrough
https://gitlab.com/risingprismtv/single-gpu-passthrough/-/wikis/home
https://github.com/joeknock90/Single-GPU-Passthrough  
https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF  

loader arch.conf
```
title Arch Linux
linux /vmlinuz-linux
initrd /amd-ucode.img
initrd /initramfs-linux.img
options root=PARTUUID=99947a68-721e-4071-aa40-8199c3fbda6e rw nvidia-drm.modeset=1 amd_iommu=on iommu=pt
```

## Docker

portainer
```
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```
adguardhome