#!/bin/bash

# Setup loop in images
losetup -P -f "$PWD/1-10G.partition"

# Scan and enable Group volumes
vgscan
vgchange -ay

# Mount encrypted volume
cryptsetup open /dev/mapper/mysecret-lvol0 securelv
mount /dev/mapper/securelv /home/lorenzo/secrets/data/
chown lorenzo:lorenzo /home/lorenzo/secrets/data/
