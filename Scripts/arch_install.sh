#!/bin/bash
# =======================================================
# 🐉 ZenzaDae Group OS - Automated Arch Linux Installer
# Author: Rumi Zen Zappalorti
# Description: Complete Arch install script with GUI,
# auto-login, VirtualBox, PipeWire, Docker, Dev Tools
# =======================================================

set -e

# === 🧠 CONFIGURATION ===
HOSTNAME="zenzadae-os"
USERNAME="zenza"
USER_PASSWORD="zenza2025"
ROOT_PASSWORD="zenzaroot2025"
TIMEZONE="UTC"
LOCALE="en_US.UTF-8"
KEYMAP="us"
DISK="/dev/sda"  # ❗ Update if different

# === 🛡️ Root Check ===
if [[ $EUID -ne 0 ]]; then
  echo "❌ This script must be run as root from the Arch Live ISO."
  exit 1
fi

echo "🌐 Enabling time sync..."
timedatectl set-ntp true

# === 💽 Partitioning ===
echo "💾 Partitioning drive $DISK..."
wipefs -af $DISK
parted $DISK --script mklabel gpt
parted $DISK --script mkpart ESP fat32 1MiB 551MiB
parted $DISK --script set 1 esp on
parted $DISK --script mkpart primary ext4 551MiB 100%

# === 📂 Formatting ===
echo "🎨 Formatting partitions..."
mkfs.fat -F32 ${DISK}1
mkfs.ext4 ${DISK}2

# === 📦 Mounting ===
echo "🔗 Mounting partitions..."
mount ${DISK}2 /mnt
mkdir -p /mnt/boot
mount ${DISK}1 /mnt/boot

# === 🔧 Install Base System ===
echo "📥 Installing base system..."
pacstrap /mnt base base-devel linux linux-firmware \
  networkmanager grub efibootmgr sudo nano vim git

# === 📝 Generate fstab ===
genfstab -U /mnt >> /mnt/etc/fstab

# === 🧠 Chroot Configuration Script ===
cat > /mnt/chroot_config.sh << EOF
#!/bin/bash
set -e

echo "⚙️ Inside chroot: configuring system..."

# Time & Locale
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc
echo "$LOCALE UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=$LOCALE" > /etc/locale.conf
echo "KEYMAP=$KEYMAP" > /etc/vconsole.conf

# Hostname & Hosts
echo "$HOSTNAME" > /etc/hostname
cat > /etc/hosts << HOSTS
127.0.0.1   localhost
::1         localhost
127.0.1.1   $HOSTNAME.localdomain $HOSTNAME
HOSTS

# Root & User
echo "root:$ROOT_PASSWORD" | chpasswd
useradd -m -G wheel,audio,video,optical,storage -s /bin/bash $USERNAME
echo "$USERNAME:$USER_PASSWORD" | chpasswd
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Bootloader
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Enable Services
systemctl enable NetworkManager

# GUI & Utilities
pacman -S --noconfirm \
  xorg-server xorg-xinit xorg-xrandr xorg-xdpyinfo \
  xfce4 xfce4-goodies lightdm lightdm-gtk-greeter \
  firefox git nodejs npm python python-pip \
  code docker docker-compose \
  neofetch htop btop \
  virtualbox-guest-utils virtualbox-guest-modules-arch

# PipeWire Audio Stack
pacman -S --noconfirm pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber sof-firmware alsa-utils
systemctl enable pipewire.service
systemctl enable pipewire-pulse.service
systemctl enable wireplumber.service

# Final Service Enables
systemctl enable lightdm
systemctl enable docker
systemctl enable vboxservice

# LightDM Autologin
mkdir -p /etc/lightdm
cat > /etc/lightdm/lightdm.conf << LIGHTDM
[Seat:*]
autologin-user=$USERNAME
autologin-user-timeout=0
LIGHTDM

# VirtualBox Modules
echo "vboxguest" >> /etc/modules-load.d/virtualbox.conf
echo "vboxsf" >> /etc/modules-load.d/virtualbox.conf
echo "vboxvideo" >> /etc/modules-load.d/virtualbox.conf

echo "✅ Chroot configuration complete!"
EOF

# === 🚀 Execute chroot ===
chmod +x /mnt/chroot_config.sh
arch-chroot /mnt /chroot_config.sh
rm /mnt/chroot_config.sh

# === ✅ Final Message ===
echo ""
echo "🎉 ZenzaDae OS base installation complete!"
echo ""
echo "🖥️  Hostname: $HOSTNAME"
echo "👤  User: $USERNAME | PW: $USER_PASSWORD"
echo "🔐  Root PW: $ROOT_PASSWORD"
echo ""
echo "💡 To reboot safely:"
echo "   umount -R /mnt && reboot"
echo ""
echo "🧩 After reboot, run:"
echo "   bash Scripts/post_install.sh"
echo "   bash Scripts/configure_vm.sh"
echo ""
echo "🌌 Welcome to the ZenzaDae OS Dimension!"
