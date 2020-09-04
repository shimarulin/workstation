#!/usr/bin/env bash
set -e

CONFIG_FILE="install.conf"

# global variables (no configuration, don't edit)
BIOS_TYPE=""
DEVICE_TYPE=""
CPU_VENDOR=""
VIRTUALBOX=""
PARTITION_PARTED_UEFI=""
PARTITION_PARTED_BIOS=""
PARTITION_PARTED_USE=""
PARTITION_BOOT=""
PARTITION_ROOT=""
PARTITION_BOOT_NUMBER=""
PARTITION_ROOT_NUMBER=""
DEVICE_ROOT=""
SWAPFILE="/swapfile"
BOOT_DIRECTORY=""
ESP_DIRECTORY=""
UUID_BOOT=""
UUID_ROOT=""
PARTUUID_BOOT=""
PARTUUID_ROOT=""

# system variables
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[1;34m'
NC='\033[0m'

function load_config() {
    source "$CONFIG_FILE"
}

function warning() {
    echo -e "${LIGHT_BLUE}Welcome to Arch Linux Install Script${NC}"
    echo ""
    echo -e "${RED}Warning"'!'"${NC}"
    echo -e "${RED}This script deletes all partitions of the persistent${NC}"
    echo -e "${RED}storage and continuing all your data in it will be lost.${NC}"
    echo ""
    read -p "Do you want to continue? [y/N] " yn
    case $yn in
        [Yy]* )
            ;;
        [Nn]* )
            exit
            ;;
        * )
            exit
            ;;
    esac
}

function load_facts() {
    if [ -d /sys/firmware/efi ]; then
        BIOS_TYPE="uefi"
    else
        BIOS_TYPE="bios"
    fi

    if [ -n "$(echo $DEVICE | grep "^/dev/[a-z]d[a-z]")" ]; then
        DEVICE_TYPE="sata"
    elif [ -n "$(echo $DEVICE | grep "^/dev/nvme")" ]; then
        DEVICE_TYPE="nvme"
    elif [ -n "$(echo $DEVICE | grep "^/dev/mmc")" ]; then
        DEVICE_TYPE="mmc"
    fi

    if [ -n "$(lscpu | grep GenuineIntel)" ]; then
        CPU_VENDOR="intel"
    elif [ -n "$(lscpu | grep AuthenticAMD)" ]; then
        CPU_VENDOR="amd"
    fi

    if [ -n "$(lspci | grep -i virtualbox)" ]; then
        VIRTUALBOX="true"
    fi
}

function configure_time() {
    timedatectl set-ntp true
}

function partition() {
    # setup
    PARTITION_PARTED_UEFI="mklabel gpt mkpart ESP fat32 1MiB 512MiB mkpart root $FILE_SYSTEM_TYPE 512MiB 100% set 1 esp on"
    PARTITION_PARTED_BIOS="mklabel msdos mkpart primary ext4 4MiB 512MiB mkpart primary $FILE_SYSTEM_TYPE 512MiB 100% set 1 boot on"

    if [ "$BIOS_TYPE" == "uefi" ]; then
        if [ "$DEVICE_TYPE" == "nvme" ]; then
            PARTITION_BOOT="${DEVICE}p1"
            PARTITION_ROOT="${DEVICE}p2"
            DEVICE_ROOT="${DEVICE}p2"
        elif [ "$DEVICE_TYPE" == "sata" ]; then
            PARTITION_BOOT="${DEVICE}1"
            PARTITION_ROOT="${DEVICE}2"
            DEVICE_ROOT="${DEVICE}2"
        elif [ "$DEVICE_TYPE" == "mmc" ]; then
            PARTITION_BOOT="${DEVICE}p1"
            PARTITION_ROOT="${DEVICE}p2"
            DEVICE_ROOT="${DEVICE}p2"
        fi

        if [ -z "$PARTITION_PARTED" ]; then
            PARTITION_PARTED_USE="$PARTITION_PARTED_UEFI"
        else
            PARTITION_PARTED_USE="$PARTITION_PARTED"
        fi
    elif [ "$BIOS_TYPE" == "bios" ]; then
        if [ "$DEVICE_TYPE" == "nvme" ]; then
            PARTITION_BOOT="${DEVICE}p1"
            PARTITION_ROOT="${DEVICE}p2"
            DEVICE_ROOT="${DEVICE}p2"
        elif [ "$DEVICE_TYPE" == "sata" ]; then
            PARTITION_BOOT="${DEVICE}1"
            PARTITION_ROOT="${DEVICE}2"
            DEVICE_ROOT="${DEVICE}2"
        elif [ "$DEVICE_TYPE" == "mmc" ]; then
            PARTITION_BOOT="${DEVICE}p1"
            PARTITION_ROOT="${DEVICE}p2"
            DEVICE_ROOT="${DEVICE}p2"
        fi

        if [ -z "$PARTITION_PARTED" ]; then
            PARTITION_PARTED_USE="$PARTITION_PARTED_BIOS"
        else
            PARTITION_PARTED_USE="$PARTITION_PARTED"
        fi
    fi

    PARTITION_BOOT_NUMBER="$PARTITION_BOOT"
    PARTITION_ROOT_NUMBER="$PARTITION_ROOT"
    PARTITION_BOOT_NUMBER="${PARTITION_BOOT_NUMBER//\/dev\/sda/}"
    PARTITION_BOOT_NUMBER="${PARTITION_BOOT_NUMBER//\/dev\/nvme0n1p/}"
    PARTITION_BOOT_NUMBER="${PARTITION_BOOT_NUMBER//\/dev\/mmcblk0p/}"
    PARTITION_ROOT_NUMBER="${PARTITION_ROOT_NUMBER//\/dev\/sda/}"
    PARTITION_ROOT_NUMBER="${PARTITION_ROOT_NUMBER//\/dev\/nvme0n1p/}"
    PARTITION_ROOT_NUMBER="${PARTITION_ROOT_NUMBER//\/dev\/mmcblk0p/}"

    # partition
    if [ "$FILE_SYSTEM_TYPE" == "f2fs" ]; then
        pacman -Sy --noconfirm f2fs-tools
    fi

    sgdisk --zap-all $DEVICE
    wipefs -a $DEVICE
    parted -s $DEVICE $PARTITION_PARTED_USE

    # format
    if [ "$BIOS_TYPE" == "uefi" ]; then
        wipefs -a $PARTITION_BOOT
        wipefs -a $DEVICE_ROOT
        mkfs.fat -n ESP -F32 $PARTITION_BOOT
        mkfs."$FILE_SYSTEM_TYPE" -L root $DEVICE_ROOT
    elif [ "$BIOS_TYPE" == "bios" ]; then
        wipefs -a $PARTITION_BOOT
        wipefs -a $DEVICE_ROOT
        mkfs."$FILE_SYSTEM_TYPE" -L boot $PARTITION_BOOT
        mkfs."$FILE_SYSTEM_TYPE" -L root $DEVICE_ROOT
    fi

    PARTITION_OPTIONS="defaults"

#    if [ "$DEVICE_TRIM" == "true" ]; then
#        if [ "$FILE_SYSTEM_TYPE" == "f2fs" ]; then
#            PARTITION_OPTIONS="$PARTITION_OPTIONS,noatime,nodiscard"
#        else
#            PARTITION_OPTIONS="$PARTITION_OPTIONS,noatime"
#        fi
#    fi

    # mount
    if [ "$FILE_SYSTEM_TYPE" == "btrfs" ]; then
        mount -o "$PARTITION_OPTIONS" "$DEVICE_ROOT" /mnt
        btrfs subvolume create /mnt/root
        btrfs subvolume create /mnt/home
        btrfs subvolume create /mnt/var
        btrfs subvolume create /mnt/snapshots
        umount /mnt

        mount -o "subvol=root,$PARTITION_OPTIONS,compress=lzo" "$DEVICE_ROOT" /mnt

        mkdir /mnt/{boot,home,var,snapshots}
        mount -o "$PARTITION_OPTIONS" "$PARTITION_BOOT" /mnt/boot
        mount -o "subvol=home,$PARTITION_OPTIONS,compress=lzo" "$DEVICE_ROOT" /mnt/home
        mount -o "subvol=var,$PARTITION_OPTIONS,compress=lzo" "$DEVICE_ROOT" /mnt/var
        mount -o "subvol=snapshots,$PARTITION_OPTIONS,compress=lzo" "$DEVICE_ROOT" /mnt/snapshots
    else
        mount -o "$PARTITION_OPTIONS" "$DEVICE_ROOT" /mnt

        mkdir /mnt/boot
        mount -o "$PARTITION_OPTIONS" "$PARTITION_BOOT" /mnt/boot
    fi

    # swap
    if [ -n "$SWAP_SIZE" ]; then
        if [ "$FILE_SYSTEM_TYPE" == "btrfs" ]; then
            truncate -s 0 /mnt$SWAPFILE
            chattr +C /mnt$SWAPFILE
            btrfs property set /mnt$SWAPFILE compression none
        fi

        dd if=/dev/zero of=/mnt$SWAPFILE bs=1M count=$SWAP_SIZE status=progress
        chmod 600 /mnt$SWAPFILE
        mkswap /mnt$SWAPFILE
    fi

    # set variables
    BOOT_DIRECTORY=/boot
    ESP_DIRECTORY=/boot
    UUID_BOOT=$(blkid -s UUID -o value $PARTITION_BOOT)
    UUID_ROOT=$(blkid -s UUID -o value $PARTITION_ROOT)
    PARTUUID_BOOT=$(blkid -s PARTUUID -o value $PARTITION_BOOT)
    PARTUUID_ROOT=$(blkid -s PARTUUID -o value $PARTITION_ROOT)
}

function install() {
    if [ -n "$PACMAN_MIRROR" ]; then
        echo "Server=$PACMAN_MIRROR" > /etc/pacman.d/mirrorlist
    fi
#    if [ "$REFLECTOR" == "true" ]; then
#        COUNTRIES=()
#        for COUNTRY in "${REFLECTOR_COUNTRIES[@]}"; do
#            COUNTRIES+=(--country "${COUNTRY}")
#        done
#        pacman -Sy --noconfirm reflector
#        reflector "${COUNTRIES[@]}" --latest 25 --age 24 --protocol https --completion-percent 100 --sort rate --save /etc/pacman.d/mirrorlist
#    fi

#    sed -i 's/#Color/Color/' /etc/pacman.conf
#    sed -i 's/#TotalDownload/TotalDownload/' /etc/pacman.conf

#    pacstrap /mnt base base-devel linux
    pacstrap /mnt base linux linux-firmware

#    sed -i 's/#Color/Color/' /mnt/etc/pacman.conf
#    sed -i 's/#TotalDownload/TotalDownload/' /mnt/etc/pacman.conf
}

# Low-level functions
function prepare() {
    timedatectl set-ntp true
    pacman -Sy
}

function main() {
    load_config
    # TODO: sanitize_variables
    # TODO: check_variables
    warning
    # TODO: init (init_log and loadkeys)
    load_facts
    # TODO: check_facts
    prepare
    partition
}
