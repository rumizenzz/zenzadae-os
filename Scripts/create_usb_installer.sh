#!/bin/bash
# ZenzaDae Group OS - USB Installer Creator
# Creates a bootable USB drive with ZenzaDae installation files

set -e

echo "🐉 ZenzaDae Group OS - USB Installer Creator"
echo "============================================"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "❌ This script must be run as root for USB operations"
   echo "Usage: sudo bash create_usb_installer.sh"
   exit 1
fi

# Function to list available USB drives
list_usb_drives() {
    echo "📱 Available USB drives:"
    lsblk -d -o NAME,SIZE,MODEL | grep -E "(sd[b-z]|nvme[1-9])" || echo "No USB drives detected"
    echo ""
}

# Function to confirm USB drive selection
confirm_usb_drive() {
    local drive=$1
    echo "⚠️  WARNING: This will COMPLETELY ERASE the USB drive: $drive"
    echo "All data on $drive will be permanently lost!"
    echo ""
    read -p "Are you sure you want to continue? (type 'YES' to confirm): " confirmation
    
    if [ "$confirmation" != "YES" ]; then
        echo "❌ Operation cancelled by user"
        exit 1
    fi
}

# Function to download Arch Linux ISO
download_arch_iso() {
    local iso_path="/tmp/archlinux.iso"
    
    if [ ! -f "$iso_path" ]; then
        echo "📥 Downloading Arch Linux ISO..."
        curl -L -o "$iso_path" "https://mirror.rackspace.com/archlinux/iso/latest/archlinux-x86_64.iso"
        
        if [ ! -f "$iso_path" ]; then
            echo "❌ Failed to download Arch Linux ISO"
            exit 1
        fi
    else
        echo "✅ Arch Linux ISO already downloaded"
    fi
    
    echo "$iso_path"
}

# Function to create bootable USB
create_bootable_usb() {
    local usb_device=$1
    local iso_path=$2
    
    echo "🔥 Creating bootable USB drive..."
    
    # Unmount the USB drive if mounted
    umount ${usb_device}* 2>/dev/null || true
    
    # Write ISO to USB drive
    echo "💾 Writing Arch Linux ISO to USB drive..."
    dd if="$iso_path" of="$usb_device" bs=4M status=progress oflag=sync
    
    echo "✅ Bootable USB created successfully!"
}

# Function to add ZenzaDae scripts to USB
add_zenzadae_scripts() {
    local usb_device=$1
    
    echo "📁 Adding ZenzaDae scripts to USB..."
    
    # Create temporary mount point
    local mount_point="/tmp/zenzadae_usb"
    mkdir -p "$mount_point"
    
    # Try to mount the USB (it might have multiple partitions)
    local mounted=false
    for partition in ${usb_device}*; do
        if mount "$partition" "$mount_point" 2>/dev/null; then
            mounted=true
            break
        fi
    done
    
    if [ "$mounted" = false ]; then
        echo "⚠️  Could not mount USB drive. Scripts will need to be added manually."
        echo "💡 After booting from USB, you can download scripts with:"
        echo "   curl -O https://raw.githubusercontent.com/zenzadae-group/scripts/main/bare_metal_install.sh"
        return
    fi
    
    # Copy ZenzaDae scripts to USB
    if [ -d "../Scripts" ]; then
        cp -r ../Scripts "$mount_point/ZenzaDae_Scripts" 2>/dev/null || true
        cp -r ../Branding "$mount_point/ZenzaDae_Branding" 2>/dev/null || true
        
        # Create installation guide on USB
        cat > "$mount_point/ZENZADAE_INSTALL.txt" << 'EOF'
🐉 ZenzaDae Group OS - Bare Metal Installation
=============================================

Quick Installation:
1. Boot from this USB drive
2. Connect to internet: wifi-menu
3. Run: bash /ZenzaDae_Scripts/bare_metal_install.sh
4. Follow the prompts
5. Reboot when complete

Manual Installation:
1. Partition disk: cfdisk /dev/sda
2. Format: mkfs.fat -F32 /dev/sda1 && mkfs.ext4 /dev/sda2
3. Mount: mount /dev/sda2 /mnt && mkdir /mnt/boot && mount /dev/sda1 /mnt/boot
4. Install: pacstrap /mnt base linux linux-firmware
5. Configure: genfstab -U /mnt >> /mnt/etc/fstab
6. Chroot: arch-chroot /mnt
7. Run: bash /ZenzaDae_Scripts/arch_install.sh
8. Install bootloader and reboot

For help: https://github.com/zenzadae-group
EOF
        
        echo "✅ ZenzaDae scripts added to USB"
    else
        echo "⚠️  ZenzaDae scripts directory not found"
    fi
    
    # Unmount USB
    umount "$mount_point"
    rmdir "$mount_point"
}

# Main execution
main() {
    echo "This script will create a bootable ZenzaDae Group OS installer USB drive."
    echo ""
    
    # List available USB drives
    list_usb_drives
    
    # Get USB drive selection
    read -p "Enter the USB drive device (e.g., /dev/sdb): " usb_device
    
    # Validate USB drive exists
    if [ ! -b "$usb_device" ]; then
        echo "❌ Device $usb_device does not exist or is not a block device"
        exit 1
    fi
    
    # Confirm operation
    confirm_usb_drive "$usb_device"
    
    # Download Arch Linux ISO
    iso_path=$(download_arch_iso)
    
    # Create bootable USB
    create_bootable_usb "$usb_device" "$iso_path"
    
    # Add ZenzaDae scripts (may fail on some systems)
    add_zenzadae_scripts "$usb_device"
    
    echo ""
    echo "🎉 ZenzaDae Group OS USB installer created successfully!"
    echo ""
    echo "📋 Next Steps:"
    echo "   1. Safely remove the USB drive"
    echo "   2. Insert USB into target computer"
    echo "   3. Boot from USB (press F12/F9/F8 during startup)"
    echo "   4. Follow installation instructions"
    echo ""
    echo "⚠️  Remember to backup all important data before installation!"
    echo ""
    echo "📞 Support: support@zenzadae.com"
}

# Check for required tools
for tool in lsblk dd curl; do
    if ! command -v $tool &> /dev/null; then
        echo "❌ Required tool '$tool' is not installed"
        echo "Please install missing tools and try again"
        exit 1
    fi
done

# Run main function
main "$@"
