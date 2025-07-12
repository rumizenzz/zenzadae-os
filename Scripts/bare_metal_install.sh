#!/bin/bash
# ZenzaDae Group OS - Bare Metal Installation Script
# Automated installation script for physical hardware

set -e

echo "🐉 ZenzaDae Group OS - Bare Metal Installer"
echo "==========================================="
echo ""
echo "⚠️  WARNING: This will install ZenzaDae Group OS directly on your computer."
echo "⚠️  ALL DATA on the selected disk will be PERMANENTLY ERASED!"
echo ""

# Configuration variables
HOSTNAME="zenzadae-os"
USERNAME="zenza"
USER_PASSWORD=""
ROOT_PASSWORD=""
TIMEZONE=""
LOCALE="en_US.UTF-8"
KEYMAP="us"
SELECTED_DISK=""
EFI_MODE=false

# Check if running in live environment
if [ ! -f /etc/arch-release ]; then
    echo "❌ This script must be run from an Arch Linux live environment"
    echo "Please boot from the ZenzaDae USB installer first"
    exit 1
fi

# Check internet connectivity
check_internet() {
    echo "🌐 Checking internet connectivity..."
    if ping -c 1 archlinux.org &> /dev/null; then
        echo "✅ Internet connection available"
    else
        echo "❌ No internet connection detected"
        echo "Please connect to internet and run this script again"
        echo ""
        echo "For WiFi: wifi-menu"
        echo "For Ethernet: dhcpcd"
        exit 1
    fi
}

# Detect EFI or BIOS
detect_boot_mode() {
    if [ -d /sys/firmware/efi ]; then
        EFI_MODE=true
        echo "✅ UEFI boot mode detected"
    else
        EFI_MODE=false
        echo "✅ BIOS boot mode detected"
    fi
}

# List available disks
list_disks() {
    echo ""
    echo "💾 Available disks:"
    lsblk -d -o NAME,SIZE,MODEL | grep -E "(sd[a-z]|nvme[0-9]|vd[a-z])"
    echo ""
}

# Get user inputs
get_user_inputs() {
    echo "📋 Installation Configuration"
    echo "============================"
    
    # Disk selection
    list_disks
    while true; do
        read -p "Select installation disk (e.g., sda, nvme0n1): " disk_input
        SELECTED_DISK="/dev/$disk_input"
        
        if [ -b "$SELECTED_DISK" ]; then
            echo "Selected disk: $SELECTED_DISK"
            break
        else
            echo "❌ Invalid disk. Please try again."
        fi
    done
    
    # Confirmation
    echo ""
    echo "⚠️  FINAL WARNING: This will ERASE ALL DATA on $SELECTED_DISK"
    lsblk "$SELECTED_DISK"
    echo ""
    read -p "Type 'ERASE' to confirm data destruction: " confirmation
    
    if [ "$confirmation" != "ERASE" ]; then
        echo "❌ Installation cancelled"
        exit 1
    fi
    
    # Timezone
    echo ""
    echo "🌍 Available timezones (examples):"
    echo "   UTC, US/Eastern, US/Pacific, Europe/London, Asia/Tokyo"
    read -p "Enter timezone (default: UTC): " tz_input
    TIMEZONE=${tz_input:-UTC}
    
    # Passwords
    echo ""
    while true; do
        read -s -p "Set password for user 'zenza': " USER_PASSWORD
        echo ""
        read -s -p "Confirm password: " password_confirm
        echo ""
        
        if [ "$USER_PASSWORD" = "$password_confirm" ]; then
            break
        else
            echo "❌ Passwords don't match. Please try again."
        fi
    done
    
    while true; do
        read -s -p "Set root password: " ROOT_PASSWORD
        echo ""
        read -s -p "Confirm root password: " root_confirm
        echo ""
        
        if [ "$ROOT_PASSWORD" = "$root_confirm" ]; then
            break
        else
            echo "❌ Passwords don't match. Please try again."
        fi
    done
    
    echo ""
    echo "📋 Installation Summary:"
    echo "   Disk: $SELECTED_DISK"
    echo "   Boot Mode: $([ "$EFI_MODE" = true ] && echo "UEFI" || echo "BIOS")"
    echo "   Timezone: $TIMEZONE"
    echo "   Username: $USERNAME"
    echo "   Hostname: $HOSTNAME"
    echo ""
    read -p "Proceed with installation? (y/N): " proceed
    
    if [[ ! "$proceed" =~ ^[Yy]$ ]]; then
        echo "❌ Installation cancelled"
        exit 1
    fi
}

# Partition the disk
partition_disk() {
    echo ""
    echo "💾 Partitioning disk $SELECTED_DISK..."
    
    # Clear the disk
    wipefs -af "$SELECTED_DISK"
    sgdisk --zap-all "$SELECTED_DISK"
    
    if [ "$EFI_MODE" = true ]; then
        # UEFI partitioning
        echo "Creating UEFI partitions..."
        sgdisk -n 1:0:+512M -t 1:ef00 -c 1:"EFI System" "$SELECTED_DISK"
        sgdisk -n 2:0:0 -t 2:8300 -c 2:"Linux filesystem" "$SELECTED_DISK"
        
        # Set partition variables
        if [[ "$SELECTED_DISK" == *"nvme"* ]]; then
            EFI_PARTITION="${SELECTED_DISK}p1"
            ROOT_PARTITION="${SELECTED_DISK}p2"
        else
            EFI_PARTITION="${SELECTED_DISK}1"
            ROOT_PARTITION="${SELECTED_DISK}2"
        fi
    else
        # BIOS partitioning
        echo "Creating BIOS partitions..."
        sgdisk -n 1:0:+1M -t 1:ef02 -c 1:"BIOS boot" "$SELECTED_DISK"
        sgdisk -n 2:0:0 -t 2:8300 -c 2:"Linux filesystem" "$SELECTED_DISK"
        
        # Set partition variables
        if [[ "$SELECTED_DISK" == *"nvme"* ]]; then
            BOOT_PARTITION="${SELECTED_DISK}p1"
            ROOT_PARTITION="${SELECTED_DISK}p2"
        else
            BOOT_PARTITION="${SELECTED_DISK}1"
            ROOT_PARTITION="${SELECTED_DISK}2"
        fi
    fi
    
    # Wait for partitions to be recognized
    sleep 2
    partprobe "$SELECTED_DISK"
    sleep 2
    
    echo "✅ Disk partitioned successfully"
}

# Format partitions
format_partitions() {
    echo ""
    echo "🎨 Formatting partitions..."
    
    if [ "$EFI_MODE" = true ]; then
        # Format EFI partition
        echo "Formatting EFI partition..."
        mkfs.fat -F32 "$EFI_PARTITION"
    fi
    
    # Format root partition
    echo "Formatting root partition..."
    mkfs.ext4 -F "$ROOT_PARTITION"
    
    echo "✅ Partitions formatted successfully"
}

# Mount filesystems
mount_filesystems() {
    echo ""
    echo "🔗 Mounting filesystems..."
    
    # Mount root
    mount "$ROOT_PARTITION" /mnt
    
    if [ "$EFI_MODE" = true ]; then
        # Mount EFI
        mkdir -p /mnt/boot
        mount "$EFI_PARTITION" /mnt/boot
    fi
    
    echo "✅ Filesystems mounted successfully"
}

# Install base system
install_base_system() {
    echo ""
    echo "📦 Installing base system..."
    
    # Update package database
    pacman -Sy
    
    # Install base packages
    pacstrap /mnt base base-devel linux linux-firmware \
        networkmanager grub efibootmgr sudo nano vim git \
        xorg-server xorg-xinit xfce4 xfce4-goodies \
        lightdm lightdm-gtk-greeter \
        firefox code nodejs npm python python-pip go docker \
        neofetch htop btop virtualbox-guest-utils
    
    echo "✅ Base system installed successfully"
}

# Configure system
configure_system() {
    echo ""
    echo "⚙️  Configuring system..."
    
    # Generate fstab
    genfstab -U /mnt >> /mnt/etc/fstab
    
    # Create chroot configuration script
    cat > /mnt/configure_chroot.sh << EOF
#!/bin/bash
set -e

# Set timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

# Set locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=$KEYMAP" > /etc/vconsole.conf

# Set hostname
echo "$HOSTNAME" > /etc/hostname
cat > /etc/hosts << HOSTS
127.0.0.1	localhost
::1		localhost
127.0.1.1	$HOSTNAME.localdomain	$HOSTNAME
HOSTS

# Set passwords
echo "root:$ROOT_PASSWORD" | chpasswd

# Create user
useradd -m -G wheel,audio,video,optical,storage,docker -s /bin/bash $USERNAME
echo "$USERNAME:$USER_PASSWORD" | chpasswd

# Configure sudo
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Enable services
systemctl enable NetworkManager
systemctl enable lightdm
systemctl enable docker

# Configure auto-login
mkdir -p /etc/lightdm
cat > /etc/lightdm/lightdm.conf << LIGHTDM
[Seat:*]
autologin-user=$USERNAME
autologin-user-timeout=0
LIGHTDM

# Install and configure GRUB
if [ "$EFI_MODE" = true ]; then
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ZenzaDae
else
    grub-install --target=i386-pc $SELECTED_DISK
fi

# Configure GRUB
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/' /etc/default/grub
sed -i 's/#GRUB_GFXMODE=.*/GRUB_GFXMODE=1920x1080/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

echo "✅ System configuration completed"
EOF

    # Make script executable and run in chroot
    chmod +x /mnt/configure_chroot.sh
    arch-chroot /mnt /configure_chroot.sh
    
    # Clean up
    rm /mnt/configure_chroot.sh
    
    echo "✅ System configured successfully"
}

# Install ZenzaDae customizations
install_zenzadae_customizations() {
    echo ""
    echo "🎨 Installing ZenzaDae customizations..."
    
    # Copy ZenzaDae scripts to the new system
    if [ -d "/ZenzaDae_Scripts" ]; then
        cp -r /ZenzaDae_Scripts /mnt/home/$USERNAME/Scripts
        chown -R 1000:1000 /mnt/home/$USERNAME/Scripts
    fi
    
    if [ -d "/ZenzaDae_Branding" ]; then
        cp -r /ZenzaDae_Branding /mnt/home/$USERNAME/Branding
        chown -R 1000:1000 /mnt/home/$USERNAME/Branding
    fi
    
    # Create post-installation script to run on first boot
    cat > /mnt/home/$USERNAME/first_boot_setup.sh << 'EOF'
#!/bin/bash
# ZenzaDae first boot setup script

echo "🐉 Setting up ZenzaDae Group OS..."

# Create ZenzaDae directory structure
mkdir -p ~/ZenzaDae/{Projects/{Automation,Websites},Media/{Branding,Music},Resources/Docs,Templates,ZenzaTerminal}

# Copy branding assets
if [ -d ~/Branding ]; then
    cp -r ~/Branding/* ~/ZenzaDae/Media/Branding/ 2>/dev/null || true
fi

# Install AUR helper (yay)
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~

# Install additional software
yay -S --noconfirm \
    discord obsidian thunderbird kdenlive vlc flameshot \
    starship bat unclutter

# Configure shell
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Apply ZenzaDae theme if available
if [ -f ~/Scripts/xfce_theme.sh ]; then
    bash ~/Scripts/xfce_theme.sh
fi

# Install lock-in mode system if available
if [ -f ~/Scripts/lock_in_system.sh ]; then
    bash ~/Scripts/lock_in_system.sh install
fi

# Set up Git
git config --global user.name "ZenzaDae User"
git config --global user.email "user@zenzadae.com"
git config --global init.defaultBranch main

# Create welcome script
cat > ~/ZenzaDae/welcome.sh << 'WELCOME'
#!/bin/bash
echo "🐉 Welcome to ZenzaDae Group OS!"
echo "================================"
echo ""
echo "Your custom operating system is ready!"
echo ""
neofetch
WELCOME
chmod +x ~/ZenzaDae/welcome.sh

# Add welcome to .bashrc
echo '~/ZenzaDae/welcome.sh' >> ~/.bashrc

# Remove this script
rm ~/first_boot_setup.sh

echo "✅ ZenzaDae Group OS setup completed!"
echo "🔄 Please reboot to complete the installation"
EOF

    chmod +x /mnt/home/$USERNAME/first_boot_setup.sh
    chown 1000:1000 /mnt/home/$USERNAME/first_boot_setup.sh
    
    echo "✅ ZenzaDae customizations installed"
}

# Main installation function
main() {
    echo "Welcome to the ZenzaDae Group OS bare metal installer!"
    echo ""
    
    # Perform checks
    check_internet
    detect_boot_mode
    
    # Get user configuration
    get_user_inputs
    
    # Perform installation
    partition_disk
    format_partitions
    mount_filesystems
    install_base_system
    configure_system
    install_zenzadae_customizations
    
    # Final message
    echo ""
    echo "🎉 ZenzaDae Group OS installation completed successfully!"
    echo ""
    echo "📋 Installation Summary:"
    echo "   ✅ System installed on $SELECTED_DISK"
    echo "   ✅ User '$USERNAME' created with auto-login"
    echo "   ✅ ZenzaDae branding and tools installed"
    echo "   ✅ Development environment configured"
    echo ""
    echo "🔄 Next Steps:"
    echo "   1. Remove the USB drive"
    echo "   2. Reboot the computer"
    echo "   3. ZenzaDae Group OS will start automatically"
    echo "   4. Run the first boot setup when prompted"
    echo ""
    echo "💡 After reboot:"
    echo "   • Login will be automatic"
    echo "   • Run: bash ~/first_boot_setup.sh"
    echo "   • Enjoy your ZenzaDae Group OS!"
    echo ""
    read -p "Press Enter to shutdown and remove USB drive..."
    
    # Cleanup and shutdown
    umount -R /mnt
    echo "System will shutdown in 5 seconds..."
    sleep 5
    shutdown now
}

# Run the installation
main "$@"
