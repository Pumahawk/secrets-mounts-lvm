# Secure LVM Image Mounter

This is a simple Bash script to help mount LVM images, including encrypted volumes, in a few easy steps.

## Features

- Automatically sets up loop devices from image files
- Scans and activates volume groups
- Opens an encrypted LVM volume
- Mounts the volume to a target directory with specified ownership

## Usage

```
./mount-secure-lvm.sh -d /mount/point --user username:groupname image1.img image2.img ...
```

## Options
- -d Destination mount point (required)
- --user User and group to own the mounted directory (e.g., alice:alice)
- --help Show help

Example

```
./mount-secure-lvm.sh -d /mnt/secure --user myuser:mygroup myvolume.img
```

## Requirements

- Bash
- losetup
- LVM tools (vgscan, vgchange)
- cryptsetup
- root privileges

