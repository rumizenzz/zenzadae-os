#!/bin/bash
# ZenzaDae Group OS - Automated Arch Linux Installation Script
# This script runs inside the Arch Linux live environment

set -e

HOSTNAME="zenzadae-os"
USERNAME="zenza"
USER_PASSWORD="zenza2025"
ROOT_PASSWORD="zenzaroot2025"
TIMEZONE="UTC"
LOCALE="en_US.UTF-8"
KEYMAP="us"

echo "🐉 ZenzaDae Group OS - Automated Arch Linux Installation"
echo "======================================================"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "❌ This script must be run as root (in Arch Live environment)"
   exit 1
fi

# Set up network and time
echo "🌐 Configuring network and time..."
timedatectl set-ntp true
sleep 2

# Disk partitioning
echo "💾 Setting up disk partitioning..."
DISK="/dev/sda"

# Clear any existing partition table
wipefs -af $DISK

# Create partition table and partitions
parted $DISK --script mklabel gpt
parted $DISK --script mkpart ESP fat32 1MiB 551MiB
parted $DISK --script set 1 esp on
parted $DISK --script mkpart primary ext4 551MiB 100%

# Format partitions
echo "🎨 Formatting partitions..."
mkfs.fat -F32 ${DISK}1
mkfs.ext4 ${DISK}2

# Mount partitions
echo "🔗 Mounting partitions..."
mount ${DISK}2 /mnt
mkdir -p /mnt/boot
mount ${DISK}1 /mnt/boot

# Install base system
echo "📦 Installing base system..."
pacstrap /mnt base base-devel linux linux-firmware networkmanager grub efibootmgr sudo nano vim git

# Generate fstab
echo "📝 Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot configuration script
cat > /mnt/chroot_config.sh << 'EOF'
#!/bin/bash
set -e

echo "⚙️  Configuring system inside chroot..."

# Set timezone
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
hwclock --systohc

# Set locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf

# Set hostname
echo "zenzadae-os" > /etc/hostname
cat > /etc/hosts << 'HOSTS'
127.0.0.1	localhost
::1		localhost
127.0.1.1	zenzadae-os.localdomain	zenzadae-os
HOSTS

# Set root password
echo "root:zenzaroot2025" | chpasswd

# Create user
useradd -m -G wheel,audio,video,optical,storage -s /bin/bash zenza
echo "zenza:zenza2025" | chpasswd

# Configure sudo
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Enable NetworkManager
systemctl enable NetworkManager

# Install and configure GRUB
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Install additional packages
pacman -S --noconfirm \
    xorg-server xorg-xinit xorg-xrandr xorg-xdpyinfo \
    xfce4 xfce4-goodies lightdm lightdm-gtk-greeter \
    firefox git nodejs npm python python-pip \
    code docker docker-compose \
    neofetch htop btop \
    virtualbox-guest-utils virtualbox-guest-modules-arch

# Enable services
systemctl enable lightdm
systemctl enable docker
systemctl enable vboxservice

# Configure auto-login
mkdir -p /etc/lightdm
cat > /etc/lightdm/lightdm.conf << 'LIGHTDM'
[Seat:*]
autologin-user=zenza
autologin-user-timeout=0
LIGHTDM

# Configure VirtualBox guest additions
echo "vboxguest" >> /etc/modules-load.d/virtualbox.conf
echo "vboxsf" >> /etc/modules-load.d/virtualbox.conf
echo "vboxvideo" >> /etc/modules-load.d/virtualbox.conf

echo "✅ Chroot configuration completed!"
EOF

# Make chroot script executable and run it
chmod +x /mnt/chroot_config.sh
arch-chroot /mnt /chroot_config.sh

# Clean up
rm /mnt/chroot_config.sh

echo "🎉 Base Arch Linux installation completed!"
echo ""
echo "📋 Installation Summary:"
echo "   Hostname: $HOSTNAME"
echo "   Username: $USERNAME"
echo "   Password: $USER_PASSWORD"
echo "   Root Password: $ROOT_PASSWORD"
echo ""
echo "🔄 Next Steps:"
echo "   1. Reboot into the new system"
echo "   2. Run post-installation configuration"
echo "   3. Install ZenzaDae branding and tools"
echo ""
echo "💡 To reboot:"
echo "   umount -R /mnt && reboot"
