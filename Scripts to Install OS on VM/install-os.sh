#!/bin/bash
# ============================================================
# 🐉 ZenzaDae Group OS - One-Line Full Installation Orchestrator
# Use inside Arch Linux live environment or VM environment
# Author: Rumi Zen Zappalorti
# ============================================================

set -e

echo ""
echo "🐉 Starting Full ZenzaDae OS Installation..."
echo "==========================================="

# Step 1: Enter repo
cd zenzadae-os || { echo "❌ Could not cd into zenzadae-os"; exit 1; }

# Step 2: Make all install scripts executable
echo "🔑 Making scripts executable..."
chmod +x Scripts/*.sh

# Step 3: Run the base Arch installer
echo "💿 Running arch_install.sh..."
bash Scripts/arch_install.sh

# Step 4: Run the post-installation setup
echo "🔧 Running post_install.sh..."
bash Scripts/post_install.sh

# Step 4.1: Fix: Ensure yay is installed (for AUR)
echo "⚙️  Installing yay (AUR helper)..."
sudo pacman -S --noconfirm --needed base-devel git
cd /opt
git clone https://aur.archlinux.org/yay.git
chown -R zenzadae:zenzadae yay
cd yay
sudo -u zenzadae makepkg -si --noconfirm
cd ~

# Step 4.2: Fix: Install Neofetch via AUR
echo "📦 Installing neofetch via yay..."
sudo -u zenzadae yay -S --noconfirm neofetch

# Step 4.3: Fix: Correct VirtualBox Guest Utils package
echo "📦 Installing VirtualBox guest utilities..."
sudo pacman -S --noconfirm virtualbox-guest-utils
sudo systemctl enable vboxservice.service

# Step 5: Configure the VM with ZenzaDae settings
echo "🎨 Running configure_vm.sh..."
bash Scripts/configure_vm.sh

echo ""
echo "✅ All installation steps completed successfully!"
echo "🔁 You may now reboot your system:  umount -R /mnt && reboot"
echo ""
