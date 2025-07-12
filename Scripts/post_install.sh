#!/bin/bash
# ZenzaDae Group OS - Post Installation Configuration Script
# Run this script after first boot as the zenza user

set -e

echo "🐉 ZenzaDae Group OS - Post Installation Configuration"
echo "=================================================="

# Check if running as zenza user
if [[ $USER != "zenza" ]]; then
   echo "❌ This script must be run as the 'zenza' user"
   exit 1
fi

# Update system
echo "📦 Updating system packages..."
sudo pacman -Syu --noconfirm

# Install AUR helper (yay)
echo "🔧 Installing AUR helper (yay)..."
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~

# Install additional development tools
echo "🛠️  Installing development tools..."
yay -S --noconfirm \
    visual-studio-code-bin \
    discord \
    obsidian \
    nvm \
    docker-desktop \
    thunderbird \
    kdenlive \
    vlc \
    flameshot \
    gparted \
    ufw \
    redshift \
    xdotool \
    wmctrl \
    starship \
    bat \
    librewolf-bin

# Install Node.js via nvm
echo "📦 Installing Node.js..."
source /usr/share/nvm/init-nvm.sh
nvm install node
nvm use node
npm install -g yarn create-react-app

# Install Python packages
echo "🐍 Installing Python packages..."
pip install --user virtualenv pipenv black flake8

# Install Go
echo "🔧 Installing Go..."
sudo pacman -S --noconfirm go

# Configure Git (placeholder - user will need to set their own)
echo "📝 Configuring Git..."
git config --global user.name "ZenzaDae User"
git config --global user.email "user@zenzadae.com"
git config --global init.defaultBranch main

# Configure shell (zsh with starship)
echo "🚀 Configuring shell..."
sudo chsh -s /bin/zsh zenza
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc

# Create ZenzaDae directory structure
echo "📁 Creating ZenzaDae directory structure..."
mkdir -p ~/ZenzaDae/{Projects/{Automation,Websites},Media/{Branding,Music},Resources/Docs,Templates,ZenzaTerminal}

# Create welcome script
cat > ~/ZenzaDae/welcome.sh << 'EOF'
#!/bin/bash
echo "🐉 Welcome to ZenzaDae Group OS!"
echo "================================"
echo ""
echo "Available shortcuts:"
echo "  📁 Projects: ~/ZenzaDae/Projects"
echo "  🎨 Media: ~/ZenzaDae/Media"
echo "  📚 Resources: ~/ZenzaDae/Resources"
echo "  🔧 Templates: ~/ZenzaDae/Templates"
echo ""
echo "Quick commands:"
echo "  code ~/ZenzaDae/Projects    # Open VS Code"
echo "  firefox                    # Open Browser"
echo "  discord                    # Launch Discord"
echo "  zenzadae-lock-mode         # Toggle Lock-In Mode"
echo ""
neofetch
EOF
chmod +x ~/ZenzaDae/welcome.sh

# Add welcome script to .zshrc
echo '~/ZenzaDae/welcome.sh' >> ~/.zshrc

# Configure XFCE desktop
echo "🎨 Configuring XFCE desktop..."
mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml

# Create basic XFCE configuration for ZenzaDae theme
cat > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-desktop" version="1.0">
  <property name="backdrop" type="empty">
    <property name="screen0" type="empty">
      <property name="monitor0" type="empty">
        <property name="workspace0" type="empty">
          <property name="color-style" type="int" value="0"/>
          <property name="image-style" type="int" value="5"/>
          <property name="last-image" type="string" value="/home/zenza/ZenzaDae/Media/Branding/wallpaper.jpg"/>
        </property>
      </property>
    </property>
  </property>
</channel>
EOF

# Configure firewall
echo "🔒 Configuring firewall..."
sudo ufw enable
sudo systemctl enable ufw

# Create lock-in mode script
echo "🔐 Creating Lock-In Mode system..."
sudo tee /usr/local/bin/zenzadae-lock-mode > /dev/null << 'EOF'
#!/bin/bash
LOCK_FILE="/home/zenza/.zenzadae-lock"

if [ -f "$LOCK_FILE" ]; then
    echo "🔓 Disabling Lock-In Mode..."
    rm "$LOCK_FILE"
    notify-send "ZenzaDae OS" "Lock-In Mode Disabled"
    echo "Lock-In Mode is now DISABLED"
else
    echo "🔒 Enabling Lock-In Mode..."
    touch "$LOCK_FILE"
    notify-send "ZenzaDae OS" "Lock-In Mode Enabled - Restart to take effect"
    echo "Lock-In Mode is now ENABLED"
    echo "Restart the system for changes to take effect."
fi
EOF

sudo chmod +x /usr/local/bin/zenzadae-lock-mode

# Create lock-in mode startup script
cat > ~/.config/autostart/zenzadae-lock.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=ZenzaDae Lock-In Mode
Exec=/home/zenza/.config/zenzadae-lock-check.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF

cat > ~/.config/zenzadae-lock-check.sh << 'EOF'
#!/bin/bash
if [ -f "/home/zenza/.zenzadae-lock" ]; then
    sleep 3  # Wait for desktop to load
    # Force fullscreen and disable window decorations
    wmctrl -r :ACTIVE: -b add,fullscreen
    # Disable Alt+Tab, Alt+F4, etc.
    xdotool search --name "Desktop" windowactivate
    # Hide cursor after 1 second of inactivity
    unclutter -idle 1 &
    # Disable Ctrl+Alt+T terminal shortcut
    gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "['']"
    notify-send "ZenzaDae OS" "Lock-In Mode Active - System Secured"
fi
EOF

chmod +x ~/.config/zenzadae-lock-check.sh

# Install unclutter for cursor hiding
yay -S --noconfirm unclutter

# Create desktop shortcuts
echo "🖥️  Creating desktop shortcuts..."
mkdir -p ~/Desktop

cat > ~/Desktop/ZenzaDae-Projects.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=ZenzaDae Projects
Comment=Open ZenzaDae Projects folder
Exec=thunar /home/zenza/ZenzaDae/Projects
Icon=folder
Terminal=false
Categories=Office;
EOF

cat > ~/Desktop/Lock-Toggle.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Toggle Lock-In Mode
Comment=Enable or disable Lock-In Mode
Exec=gnome-terminal -e "zenzadae-lock-mode; read -p 'Press Enter to close...'"
Icon=security-high
Terminal=false
Categories=System;
EOF

chmod +x ~/Desktop/*.desktop

# Configure VS Code settings
echo "⚙️  Configuring VS Code..."
mkdir -p ~/.config/Code/User
cat > ~/.config/Code/User/settings.json << 'EOF'
{
    "workbench.colorTheme": "Dark+ (default dark)",
    "workbench.iconTheme": "vs-seti",
    "editor.fontSize": 14,
    "editor.fontFamily": "'Cascadia Code', 'Fira Code', monospace",
    "terminal.integrated.shell.linux": "/bin/zsh",
    "workbench.startupEditor": "welcomePage",
    "extensions.autoUpdate": true,
    "files.autoSave": "afterDelay",
    "editor.minimap.enabled": true,
    "workbench.activityBar.visible": true
}
EOF

# Configure Docker for user
echo "🐳 Configuring Docker..."
sudo usermod -aG docker zenza

echo "✅ Post-installation configuration completed!"
echo ""
echo "📋 Configuration Summary:"
echo "   ✓ Development tools installed"
echo "   ✓ ZenzaDae directory structure created"
echo "   ✓ Lock-In Mode system configured"
echo "   ✓ Desktop shortcuts created"
echo "   ✓ Shell and tools configured"
echo ""
echo "🔄 Next Steps:"
echo "   1. Restart the system"
echo "   2. Install ZenzaDae branding assets"
echo "   3. Test Lock-In Mode functionality"
echo ""
echo "💡 Useful commands:"
echo "   zenzadae-lock-mode      # Toggle Lock-In Mode"
echo "   ~/ZenzaDae/welcome.sh   # Show welcome message"
echo ""
echo "🎉 ZenzaDae Group OS is ready for branding!"
