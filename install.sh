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
VIRTUALBOX=""
CMDLINE_LINUX_ROOT=""
CMDLINE_LINUX=""

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

function pacman_install() {
    set +e
    IFS=' ' PACKAGES=($1)
    for VARIABLE in {1..5}
    do
        arch-chroot /mnt pacman -Syu --noconfirm --needed ${PACKAGES[@]}
        if [ $? == 0 ]; then
            break
        else
            sleep 10
        fi
    done
    set -e
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

function configuration() {
    genfstab -U /mnt >> /mnt/etc/fstab

    if [ -n "$SWAP_SIZE" ]; then
        echo "# swap" >> /mnt/etc/fstab
        echo "$SWAPFILE none swap defaults 0 0" >> /mnt/etc/fstab
        echo "" >> /mnt/etc/fstab
    fi

    if [ "$DEVICE_TRIM" == "true" ]; then
        if [ "$FILE_SYSTEM_TYPE" == "f2fs" ]; then
            sed -i 's/relatime/noatime,nodiscard/' /mnt/etc/fstab
        else
            sed -i 's/relatime/noatime/' /mnt/etc/fstab
        fi
        arch-chroot /mnt systemctl enable fstrim.timer
    fi

    arch-chroot /mnt ln -s -f $TIMEZONE /etc/localtime
    arch-chroot /mnt hwclock --systohc

    pacman_install "terminus-font"
    for LOCALE in "${LOCALES[@]}"; do
        sed -i "s/#$LOCALE/$LOCALE/" /etc/locale.gen
        sed -i "s/#$LOCALE/$LOCALE/" /mnt/etc/locale.gen
    done
    locale-gen
    arch-chroot /mnt locale-gen
    for VARIABLE in "${LOCALE_CONF[@]}"; do
        localectl set-locale "$VARIABLE"
        echo -e "$VARIABLE" >> /mnt/etc/locale.conf
    done
    echo -e "$KEYMAP\n$FONT\n$FONT_MAP" > /mnt/etc/vconsole.conf
    echo $HOSTNAME > /mnt/etc/hostname

    OPTIONS=""
    if [ -n "$KEYLAYOUT" ]; then
        OPTIONS="$OPTIONS"$'\n'"    Option \"XkbLayout\" \"$KEYLAYOUT\""
    fi
    if [ -n "$KEYMODEL" ]; then
        OPTIONS="$OPTIONS"$'\n'"    Option \"XkbModel\" \"$KEYMODEL\""
    fi
    if [ -n "$KEYVARIANT" ]; then
        OPTIONS="$OPTIONS"$'\n'"    Option \"XkbVariant\" \"$KEYVARIANT\""
    fi
    if [ -n "$KEYOPTIONS" ]; then
        OPTIONS="$OPTIONS"$'\n'"    Option \"XkbOptions\" \"$KEYOPTIONS\""
    fi

#    arch-chroot /mnt mkdir -p "/etc/X11/xorg.conf.d/"
#    cat <<EOT > /mnt/etc/X11/xorg.conf.d/00-keyboard.conf
## Written by systemd-localed(8), read by systemd-localed and Xorg. It's
## probably wise not to edit this file manually. Use localectl(1) to
## instruct systemd-localed to update it.
#Section "InputClass"
#    Identifier "system-keyboard"
#    MatchIsKeyboard "on"
#    $OPTIONS
#EndSection
#EOT

    if [ -n "$SWAP_SIZE" ]; then
        echo "vm.swappiness=10" > /mnt/etc/sysctl.d/99-sysctl.conf
    fi

    printf "$ROOT_PASSWORD\n$ROOT_PASSWORD" | arch-chroot /mnt passwd
}

function mkinitcpio_configuration() {
    print_step "mkinitcpio_configuration()"

    if [ "$KMS" == "true" ]; then
        MODULES=""
        case "$DISPLAY_DRIVER" in
            "intel" )
                MODULES="i915"
                ;;
            "nvidia" | "nvidia-lts"  | "nvidia-dkms" | "nvidia-390xx" | "nvidia-390xx-lts" | "nvidia-390xx-dkms" )
                MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
                ;;
            "amdgpu" )
                MODULES="amdgpu"
                ;;
            "ati" )
                MODULES="radeon"
                ;;
            "nouveau" )
                MODULES="nouveau"
                ;;
        esac
        arch-chroot /mnt sed -i "s/^MODULES=()/MODULES=($MODULES)/" /etc/mkinitcpio.conf
    fi

#    if [ "$LVM" == "true" ]; then
#        pacman_install "lvm2"
#    fi
    if [ "$FILE_SYSTEM_TYPE" == "btrfs" ]; then
        pacman_install "btrfs-progs"
    fi
    if [ "$FILE_SYSTEM_TYPE" == "f2fs" ]; then
        pacman_install "f2fs-tools"
    fi

    if [ "$BOOTLOADER" == "systemd" ]; then
        HOOKS=$(echo $HOOKS | sed 's/!systemd/systemd/')
        HOOKS=$(echo $HOOKS | sed 's/!sd-vconsole/sd-vconsole/')
        if [ "$LVM" == "true" ]; then
            HOOKS=$(echo $HOOKS | sed 's/!sd-lvm2/sd-lvm2/')
        fi
        if [ -n "$LUKS_PASSWORD" ]; then
            HOOKS=$(echo $HOOKS | sed 's/!sd-encrypt/sd-encrypt/')
        fi
    else
        HOOKS=$(echo $HOOKS | sed 's/!udev/udev/')
        HOOKS=$(echo $HOOKS | sed 's/!usr/usr/')
        HOOKS=$(echo $HOOKS | sed 's/!keymap/keymap/')
        HOOKS=$(echo $HOOKS | sed 's/!consolefont/consolefont/')
#        if [ "$LVM" == "true" ]; then
#            HOOKS=$(echo $HOOKS | sed 's/!lvm2/lvm2/')
#        fi
#        if [ -n "$LUKS_PASSWORD" ]; then
#            HOOKS=$(echo $HOOKS | sed 's/!encrypt/encrypt/')
#        fi
    fi
    HOOKS=$(sanitize_variable "$HOOKS")
    arch-chroot /mnt sed -i "s/^HOOKS=(.*)$/HOOKS=($HOOKS)/" /etc/mkinitcpio.conf

    if [ "$KERNELS_COMPRESSION" != "" ]; then
        arch-chroot /mnt sed -i 's/^#COMPRESSION="'"$KERNELS_COMPRESSION"'"/COMPRESSION="'"$KERNELS_COMPRESSION"'"/' /etc/mkinitcpio.conf
    fi

    # mkinitcpio()
    arch-chroot /mnt mkinitcpio -P
}

function network() {
    pacman_install "networkmanager"
    arch-chroot /mnt systemctl enable NetworkManager.service
}

function users() {
    create_user "$USER_NAME" "$USER_PASSWORD"

#    for U in ${ADDITIONAL_USERS[@]}; do
#        IFS='=' S=(${U})
#        USER=${S[0]}
#        PASSWORD=${S[1]}
#        create_user "${USER}" "${PASSWORD}"
#    done

	arch-chroot /mnt sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

    pacman_install "xdg-user-dirs"

#    if [ "$SYSTEMD_HOMED" == "true" ]; then
#        cat <<EOT > "/mnt/etc/pam.d/nss-auth"
##%PAM-1.0
#
#auth     sufficient pam_unix.so try_first_pass nullok
#auth     sufficient pam_systemd_home.so
#auth     required   pam_deny.so
#
#account  sufficient pam_unix.so
#account  sufficient pam_systemd_home.so
#account  required   pam_deny.so
#
#password sufficient pam_unix.so try_first_pass nullok sha512 shadow
#password sufficient pam_systemd_home.so
#password required   pam_deny.so
#EOT
#
#        cat <<EOT > "/mnt/etc/pam.d/system-auth"
##%PAM-1.0
#
#auth      substack   nss-auth
#auth      optional   pam_permit.so
#auth      required   pam_env.so
#
#account   substack   nss-auth
#account   optional   pam_permit.so
#account   required   pam_time.so
#
#password  substack   nss-auth
#password  optional   pam_permit.so
#
#session   required  pam_limits.so
#session   optional  pam_systemd_home.so
#session   required  pam_unix.so
#session   optional  pam_permit.so
#EOT
#    fi
}

function create_user() {
    USER_NAME=$1
    USER_PASSWORD=$2
#    if [ "$SYSTEMD_HOMED" == "true" ]; then
#        arch-chroot /mnt systemctl enable systemd-homed.service
#        create_user_homectl $USER_NAME $USER_PASSWORD
##       create_user_useradd $USER_NAME $USER_PASSWORD
#    else
#        create_user_useradd $USER_NAME $USER_PASSWORD
#    fi
    create_user_useradd $USER_NAME $USER_PASSWORD
}

function create_user_useradd() {
    USER_NAME=$1
    USER_PASSWORD=$2
    arch-chroot /mnt useradd -m -G wheel,storage,optical -s /bin/bash $USER_NAME
    printf "$USER_PASSWORD\n$USER_PASSWORD" | arch-chroot /mnt passwd $USER_NAME
}

function bootloader() {
    print_step "bootloader()"

    BOOTLOADER_ALLOW_DISCARDS=""

    if [ "$VIRTUALBOX" != "true" ]; then
        if [ "$CPU_VENDOR" == "intel" ]; then
            pacman_install "intel-ucode"
        fi
        if [ "$CPU_VENDOR" == "amd" ]; then
            pacman_install "amd-ucode"
        fi
    fi
    if [ "$LVM" == "true" ]; then
        CMDLINE_LINUX_ROOT="root=$DEVICE_ROOT"
    else
        CMDLINE_LINUX_ROOT="root=PARTUUID=$PARTUUID_ROOT"
    fi
    if [ -n "$LUKS_PASSWORD" ]; then
        if [ "$DEVICE_TRIM" == "true" ]; then
            BOOTLOADER_ALLOW_DISCARDS=":allow-discards"
        fi
        CMDLINE_LINUX="cryptdevice=PARTUUID=$PARTUUID_ROOT:$LUKS_DEVICE_NAME$BOOTLOADER_ALLOW_DISCARDS"
    fi
    if [ "$FILE_SYSTEM_TYPE" == "btrfs" ]; then
        CMDLINE_LINUX="$CMDLINE_LINUX rootflags=subvol=root"
    fi
    if [ "$KMS" == "true" ]; then
        case "$DISPLAY_DRIVER" in
            "nvidia" | "nvidia-390xx" | "nvidia-390xx-lts" )
                CMDLINE_LINUX="$CMDLINE_LINUX nvidia-drm.modeset=1"
                ;;
        esac
    fi

    if [ -n "$KERNELS_PARAMETERS" ]; then
        CMDLINE_LINUX="$CMDLINE_LINUX $KERNELS_PARAMETERS"
    fi

    case "$BOOTLOADER" in
        "grub" )
            bootloader_grub
            ;;
        "refind" )
            bootloader_refind
            ;;
        "systemd" )
            bootloader_systemd
            ;;
    esac

    arch-chroot /mnt systemctl set-default multi-user.target
}

function bootloader_grub() {
    pacman_install "grub dosfstools"
    arch-chroot /mnt sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/' /etc/default/grub
    arch-chroot /mnt sed -i 's/#GRUB_SAVEDEFAULT="true"/GRUB_SAVEDEFAULT="true"/' /etc/default/grub
    arch-chroot /mnt sed -i -E 's/GRUB_CMDLINE_LINUX_DEFAULT="(.*) quiet"/GRUB_CMDLINE_LINUX_DEFAULT="\1"/' /etc/default/grub
    arch-chroot /mnt sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="'"$CMDLINE_LINUX"'"/' /etc/default/grub
    echo "" >> /mnt/etc/default/grub
    echo "# alis" >> /mnt/etc/default/grub
    echo "GRUB_DISABLE_SUBMENU=y" >> /mnt/etc/default/grub

    if [ "$BIOS_TYPE" == "uefi" ]; then
        pacman_install "efibootmgr"
        arch-chroot /mnt grub-install --target=x86_64-efi --bootloader-id=grub --efi-directory=$ESP_DIRECTORY --recheck
        #arch-chroot /mnt efibootmgr --create --disk $DEVICE --part $PARTITION_BOOT_NUMBER --loader /EFI/grub/grubx64.efi --label "GRUB Boot Manager"
    fi
    if [ "$BIOS_TYPE" == "bios" ]; then
        arch-chroot /mnt grub-install --target=i386-pc --recheck $DEVICE
    fi

    arch-chroot /mnt grub-mkconfig -o "$BOOT_DIRECTORY/grub/grub.cfg"

    if [ "$VIRTUALBOX" == "true" ]; then
        echo -n "\EFI\grub\grubx64.efi" > "/mnt$ESP_DIRECTORY/startup.nsh"
    fi
}

function bootloader_refind() {
    pacman_install "refind-efi"
    arch-chroot /mnt refind-install

    arch-chroot /mnt rm /boot/refind_linux.conf
    arch-chroot /mnt sed -i 's/^timeout.*/timeout 5/' "$ESP_DIRECTORY/EFI/refind/refind.conf"
    arch-chroot /mnt sed -i 's/^#scan_all_linux_kernels.*/scan_all_linux_kernels false/' "$ESP_DIRECTORY/EFI/refind/refind.conf"
    #arch-chroot /mnt sed -i 's/^#default_selection "+,bzImage,vmlinuz"/default_selection "+,bzImage,vmlinuz"/' "$ESP_DIRECTORY/EFI/refind/refind.conf"

    REFIND_MICROCODE=""

    if [ "$VIRTUALBOX" != "true" ]; then
        if [ "$CPU_VENDOR" == "intel" ]; then
            REFIND_MICROCODE="initrd=/intel-ucode.img"
        fi
        if [ "$CPU_VENDOR" == "amd" ]; then
            REFIND_MICROCODE="initrd=/amd-ucode.img"
        fi
    fi

    cat <<EOT >> "/mnt$ESP_DIRECTORY/EFI/refind/refind.conf"
# alis
menuentry "Arch Linux" {
    volume   $PARTUUID_BOOT
    loader   /vmlinuz-linux
    initrd   /initramfs-linux.img
    icon     /EFI/refind/icons/os_arch.png
    options  "$REFIND_MICROCODE $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX"
    submenuentry "Boot using fallback initramfs"
	      initrd /initramfs-linux-fallback.img"
    }
    submenuentry "Boot to terminal"
	      add_options "systemd.unit=multi-user.target"
    }
}"

EOT
    if [[ $KERNELS =~ .*linux-lts.* ]]; then
        cat <<EOT >> "/mnt$ESP_DIRECTORY/EFI/refind/refind.conf"
menuentry "Arch Linux (lts)" {
    volume   $PARTUUID_BOOT
    loader   /vmlinuz-linux-lts
    initrd   /initramfs-linux-lts.img
    icon     /EFI/refind/icons/os_arch.png
    options  "$REFIND_MICROCODE $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX"
    submenuentry "Boot using fallback initramfs" {
	      initrd /initramfs-linux-lts-fallback.img
    }
    submenuentry "Boot to terminal" {
	      add_options "systemd.unit=multi-user.target"
    }
}

EOT
    fi
    if [[ $KERNELS =~ .*linux-hardened.* ]]; then
        cat <<EOT >> "/mnt$ESP_DIRECTORY/EFI/refind/refind.conf"
menuentry "Arch Linux (hardened)" {
    volume   $PARTUUID_BOOT
    loader   /vmlinuz-linux-hardened
    initrd   /initramfs-linux-hardened.img
    icon     /EFI/refind/icons/os_arch.png
    options  "$REFIND_MICROCODE $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX"
    submenuentry "Boot using fallback initramfs" {
	      initrd /initramfs-linux-lts-fallback.img
    }
    submenuentry "Boot to terminal" {
	      add_options "systemd.unit=multi-user.target"
    }
}

EOT
    fi
    if [[ $KERNELS =~ .*linux-zen.* ]]; then
        cat <<EOT >> "/mnt$ESP_DIRECTORY/EFI/refind/refind.conf"
menuentry "Arch Linux (zen)" {
    volume   $PARTUUID_BOOT
    loader   /vmlinuz-linux-zen
    initrd   /initramfs-linux-zen.img
    icon     /EFI/refind/icons/os_arch.png
    options  "$REFIND_MICROCODE $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX"
    submenuentry "Boot using fallback initramfs" {
	      initrd /initramfs-linux-lts-fallback.img
    }
    submenuentry "Boot to terminal" {
	      add_options "systemd.unit=multi-user.target"
    }
}

EOT
    fi

    if [ "$VIRTUALBOX" == "true" ]; then
        echo -n "\EFI\refind\refind_x64.efi" > "/mnt$ESP_DIRECTORY/startup.nsh"
    fi
}

function bootloader_systemd() {
    arch-chroot /mnt systemd-machine-id-setup
    arch-chroot /mnt bootctl --path="$ESP_DIRECTORY" install

    arch-chroot /mnt mkdir -p "$ESP_DIRECTORY/loader/"
    arch-chroot /mnt mkdir -p "$ESP_DIRECTORY/loader/entries/"

    cat <<EOT > "/mnt$ESP_DIRECTORY/loader/loader.conf"
# alis
timeout 5
default archlinux
editor 0
EOT

    arch-chroot /mnt mkdir -p "/etc/pacman.d/hooks/"

    cat <<EOT > "/mnt/etc/pacman.d/hooks/systemd-boot.hook"
[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Updating systemd-boot
When = PostTransaction
Exec = /usr/bin/bootctl update
EOT

    SYSTEMD_MICROCODE=""
    SYSTEMD_OPTIONS=""

    if [ "$VIRTUALBOX" != "true" ]; then
        if [ "$CPU_VENDOR" == "intel" ]; then
            SYSTEMD_MICROCODE="/intel-ucode.img"
        fi
        if [ "$CPU_VENDOR" == "amd" ]; then
            SYSTEMD_MICROCODE="/amd-ucode.img"
        fi
    fi

    if [ -n "$LUKS_PASSWORD" ]; then
       SYSTEMD_OPTIONS="luks.name=$UUID_ROOT=$LUKS_DEVICE_NAME luks.options=discard"
    fi

    echo "title Arch Linux" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux.conf"
    echo "efi /vmlinuz-linux" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux.conf"
    if [ -n "$SYSTEMD_MICROCODE" ]; then
        echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux.conf"
    fi
    echo "initrd /initramfs-linux.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux.conf"
    echo "options initrd=initramfs-linux.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux.conf"

    echo "title Arch Linux (terminal)" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-terminal.conf"
    echo "efi /vmlinuz-linux" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-terminal.conf"
    if [ -n "$SYSTEMD_MICROCODE" ]; then
        echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-terminal.conf"
    fi
    echo "initrd /initramfs-linux.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-terminal.conf"
    echo "options initrd=initramfs-linux.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX systemd.unit=multi-user.target $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-terminal.conf"

    echo "title Arch Linux (fallback)" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-fallback.conf"
    echo "efi /vmlinuz-linux" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-fallback.conf"
    if [ -n "$SYSTEMD_MICROCODE" ]; then
        echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-fallback.conf"
    fi
    echo "initrd /initramfs-linux-fallback.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-fallback.conf"
    echo "options initrd=initramfs-linux-fallback.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-fallback.conf"

    if [[ $KERNELS =~ .*linux-lts.* ]]; then
        echo "title Arch Linux (lts)" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts.conf"
        echo "efi /vmlinuz-linux-lts" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts.conf"
        if [ -n "$SYSTEMD_MICROCODE" ]; then
            echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts.conf"
        fi
        echo "initrd /initramfs-linux-lts.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts.conf"
        echo "options initrd=initramfs-linux-lts.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts.conf"

        echo "title Arch Linux (lts, terminal)" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts-terminal.conf"
        echo "efi /vmlinuz-linux-lts" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts-terminal.conf"
        if [ -n "$SYSTEMD_MICROCODE" ]; then
            echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts-terminal.conf"
        fi
        echo "initrd /initramfs-linux-lts.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts-terminal.conf"
        echo "options initrd=initramfs-linux-lts.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX systemd.unit=multi-user.target $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts-terminal.conf"

        echo "title Arch Linux (lts-fallback)" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts-fallback.conf"
        echo "efi /vmlinuz-linux-lts" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts-fallback.conf"
        if [ "$CPU_INTEL" == "true" -a "$VIRTUALBOX" != "true" ]; then
            echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts-fallback.conf"
        fi
        echo "initrd /initramfs-linux-lts-fallback.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts-fallback.conf"
        echo "options initrd=initramfs-linux-lts-fallback.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-lts-fallback.conf"
    fi

    if [[ $KERNELS =~ .*linux-hardened.* ]]; then
        echo "title Arch Linux (hardened)" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened.conf"
        echo "efi /vmlinuz-linux-hardened" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened.conf"
        if [ -n "$SYSTEMD_MICROCODE" ]; then
            echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened.conf"
        fi
        echo "initrd /initramfs-linux-hardened.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened.conf"
        echo "options initrd=initramfs-linux-hardened.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened.conf"

        echo "title Arch Linux (hardened, terminal)" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened-terminal.conf"
        echo "efi /vmlinuz-linux-hardened" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened-terminal.conf"
        if [ -n "$SYSTEMD_MICROCODE" ]; then
            echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened-terminal.conf"
        fi
        echo "initrd /initramfs-linux-hardened.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened-terminal.conf"
        echo "options initrd=initramfs-linux-hardened.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX systemd.unit=multi-user.target $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened-terminal.conf"

        echo "title Arch Linux (hardened-fallback)" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened-fallback.conf"
        echo "efi /vmlinuz-linux-hardened" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened-fallback.conf"
        if [ -n "$SYSTEMD_MICROCODE" ]; then
            echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened-fallback.conf"
        fi
        echo "initrd /initramfs-linux-hardened-fallback.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened-fallback.conf"
        echo "options initrd=initramfs-linux-hardened-fallback.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-hardened-fallback.conf"
    fi

    if [[ $KERNELS =~ .*linux-zen.* ]]; then
        echo "title Arch Linux (zen)" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen.conf"
        echo "efi /vmlinuz-linux-zen" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen.conf"
        if [ -n "$SYSTEMD_MICROCODE" ]; then
            echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen.conf"
        fi
        echo "initrd /initramfs-linux-zen.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen.conf"
        echo "options initrd=initramfs-linux-zen.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen.conf"

        echo "title Arch Linux (zen, terminal)" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen-terminal.conf"
        echo "efi /vmlinuz-linux-zen" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen-terminal.conf"
        if [ -n "$SYSTEMD_MICROCODE" ]; then
            echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen-terminal.conf"
        fi
        echo "initrd /initramfs-linux-zen.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen-terminal.conf"
        echo "options initrd=initramfs-linux-zen.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX systemd.unit=multi-user.target $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen-terminal.conf"

        echo "title Arch Linux (zen-fallback)" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen-fallback.conf"
        echo "efi /vmlinuz-linux-zen" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen-fallback.conf"
        if [ -n "$SYSTEMD_MICROCODE" ]; then
            echo "initrd $SYSTEMD_MICROCODE" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen-fallback.conf"
        fi
        echo "initrd /initramfs-linux-zen-fallback.img" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen-fallback.conf"
        echo "options initrd=initramfs-linux-zen-fallback.img $CMDLINE_LINUX_ROOT rw $CMDLINE_LINUX $SYSTEMD_OPTIONS" >> "/mnt$ESP_DIRECTORY/loader/entries/archlinux-zen-fallback.conf"
    fi

    if [ "$VIRTUALBOX" == "true" ]; then
        echo -n "\EFI\systemd\systemd-bootx64.efi" > "/mnt$ESP_DIRECTORY/startup.nsh"
    fi
}

function end() {
    umount -R /mnt/boot
    umount -R /mnt
    reboot
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
    install
    mkinitcpio_configuration
    network
    users
    bootloader
    end
}
