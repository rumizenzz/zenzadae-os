#!/bin/bash
# ====================================================
# 🐉 ZenzaDae Group OS - Virtual Machine Configuration
# Run as the 'zenza' user after first boot
# Author: Rumi Zen Zappalorti
# ====================================================

set -e

echo ""
echo "🐉 ZenzaDae Group OS - Virtual Machine Configuration"
echo "===================================================="

# === 🔒 Ensure correct user ===
if [[ $USER != "zenza" ]]; then
  echo "❌ This script must be run as the 'zenza' user (currently: $USER)"
  exit 1
fi

# === 📁 Create ZenzaDae Folder Structure ===
echo "📁 Creating ZenzaDae project directories..."
mkdir -p ~/ZenzaDae/Projects/{Automation,Websites}
mkdir -p ~/ZenzaDae/Media/{Branding,Music}
mkdir -p ~/ZenzaDae/Resources/Docs
mkdir -p ~/ZenzaDae/Templates
mkdir -p ~/ZenzaDae/ZenzaTerminal
mkdir -p ~/.config/zenzadae

# === 🎨 Install Branding Assets ===
BRANDING_SRC="/media/shared/Branding"
BRANDING_DEST=~/ZenzaDae/Media/Branding

if [ -d "$BRANDING_SRC" ]; then
  echo "🎨 Copying branding assets from $BRANDING_SRC..."
  cp -r "$BRANDING_SRC"/* "$BRANDING_DEST"/ 2>/dev/null || true
else
  echo "⚠️  Branding folder not found at $BRANDING_SRC (skipped)"
fi

# === 🖼️ Set Wallpaper if Exists ===
WALLPAPER="$BRANDING_DEST/wallpaper.jpg"
if [ -f "$WALLPAPER" ]; then
  echo "🖼️  Setting desktop wallpaper..."
  xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s "$WALLPAPER" || \
    echo "⚠️  Failed to set XFCE wallpaper"
else
  echo "⚠️  Wallpaper not found at $WALLPAPER"
fi

# === 🔐 Install Lock-In Mode System ===
LOCKIN_SRC="/media/shared/Scripts/lock_in_system.sh"
LOCKIN_DEST=~/.config/zenzadae/lock_in_system.sh

if [ -f "$LOCKIN_SRC" ]; then
  echo "🔐 Installing Lock-In Mode system..."
  cp "$LOCKIN_SRC" "$LOCKIN_DEST"
  bash "$LOCKIN_DEST" install || echo "⚠️  Lock-In Mode script failed to run"
else
  echo "⚠️  Lock-In Mode script not found at $LOCKIN_SRC"
fi

# === 🎨 Apply XFCE Theme Script ===
THEME_SCRIPT="/media/shared/Scripts/xfce_theme.sh"
if [ -f "$THEME_SCRIPT" ]; then
  echo "🎨 Applying XFCE theme..."
  bash "$THEME_SCRIPT" || echo "⚠️  Theme script failed"
else
  echo "⚠️  Theme script not found at $THEME_SCRIPT"
fi

# === ✅ Final Message ===
echo ""
echo "✅ ZenzaDae VM configuration completed!"
echo "🔄 Please restart your session or reboot for all settings to take full effect."
echo ""
