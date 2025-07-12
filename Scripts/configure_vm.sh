#!/bin/bash
# ZenzaDae Group OS - VM Configuration Helper
# Run this script inside the VM after first boot

echo "🐉 ZenzaDae Group OS - VM Configuration"
echo "======================================="

# Ensure running as zenza user
if [[ $USER != "zenza" ]]; then
   echo "❌ This script must be run as the 'zenza' user"
   exit 1
fi

# Create ZenzaDae directory structure if not exists
echo "📁 Setting up ZenzaDae directories..."
mkdir -p ~/ZenzaDae/{Projects/{Automation,Websites},Media/{Branding,Music},Resources/Docs,Templates,ZenzaTerminal}

# Copy branding assets
echo "🎨 Installing branding assets..."
if [ -d "/media/shared/Branding" ]; then
    cp -r /media/shared/Branding/* ~/ZenzaDae/Media/Branding/ 2>/dev/null || true
fi

# Set up wallpaper
if [ -f ~/ZenzaDae/Media/Branding/wallpaper.jpg ]; then
    # Update XFCE wallpaper setting
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s ~/ZenzaDae/Media/Branding/wallpaper.jpg
fi

# Install lock-in mode system
echo "🔐 Installing Lock-In Mode system..."
if [ -f "/media/shared/Scripts/lock_in_system.sh" ]; then
    cp /media/shared/Scripts/lock_in_system.sh ~/.config/zenzadae/
    bash ~/.config/zenzadae/lock_in_system.sh install
fi

# Apply XFCE theme
echo "🎨 Applying XFCE theme..."
if [ -f "/media/shared/Scripts/xfce_theme.sh" ]; then
    bash /media/shared/Scripts/xfce_theme.sh
fi

echo "✅ VM configuration completed!"
echo "🔄 Please restart the desktop session or reboot for full effect."
