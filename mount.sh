#!/bin/bash

LV_NAME="${LV_NAME-"/dev/mapper/mysecret-lvol0"}"
LV_NAME_OPEN="${LV_NAME_OPEN-"securelv"}"

# arg: -f
PARTITIONS=()


# Read all arguments
while [[ -n "$1" ]]; do
	case "$1" in
		-d)
			DESTINATION_MOUNT="$2";
			shift;
			;;
		--user)
			USER_GROUP="$2"
			shift;
			;;
		--help)
			echo "--help        Print this message";
			echo "-d            Destination mount";
			echo "--user        User";
			exit 1;
			;;
		*)
			break;
			;;
	esac
	shift;
done

DESTINATION_MOUNT="${DESTINATION_MOUNT?"Mandatory parameter destination"}"
USER_GROUP="${USER_GROUP?"Mandatory parameter user"}"

PARTITIONS+=( "$@" )

# Setup loop in images
for image in "${PARTITIONS[@]}"; do
	losetup -P -f "$image"
done

# Scan and enable Group volumes
vgscan
vgchange -ay

# Mount encrypted volume
cryptsetup open "$LV_NAME" "$LV_NAME_OPEN"
mount /dev/mapper/${LV_NAME_OPEN} "$DESTINATION_MOUNT"
chown "$USER_GROUP" "$DESTINATION_MOUNT"
