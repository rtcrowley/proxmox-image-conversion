# Proxmox Image Converter

A bash script to convert **.OVA** into **.QCOW2** - which are Proxmox compatible images.

This script will create a working folder, decompress the ova, convert the vmdk into qcow2, move qcow2 into respective Proxmox VM ID directory, then remove the working directory. 

```
root@proxmox:/# ./prox-convert.sh
--------------------------------Usage----------------------------------
-f = Location of image you'd like to convert
-p = Proxmox VM number where converted image is to be placed
     First, you must create a new blank VM via the GUI
-n = New image name w/o extension. eg: coolVM
-----------------------------------------------------------------------

root@proxmox:/# ./prox-convert.sh -f GoldenEye.ova -p 107 -n goldeneye
```

A new blank VM will need to be created via the GUI first:

- Create VM > "Do not use any media"
- Select Disk and Memory size similar to original, prior to ova compression
- Take note of VM ID and verify as to avoid any overwriting

