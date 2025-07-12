# 🐉 ZenzaDae Group OS - Installation Guide

> **A complete virtual operating system that runs fullscreen from Windows**

[![Version](https://img.shields.io/badge/Version-1.1-purple)](https://github.com/zenzadae-group)
[![OS](https://img.shields.io/badge/Base-Arch%20Linux-blue)](https://archlinux.org/)
[![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-green)](https://microsoft.com/windows)

---

## 🎯 What is ZenzaDae Group OS?

ZenzaDae Group OS is a **custom Arch Linux virtual machine** that:
- 🖥️ **Launches automatically** at Windows startup
- 🔒 **Runs fullscreen** like a native operating system  
- 🛡️ **Includes Lock-In Mode** to restrict access to Windows host
- ⚙️ **Pre-configured** with development tools and ZenzaDae branding
- 🎨 **Fully branded** with custom themes, wallpapers, and colors

---

## 📋 System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| **OS** | Windows 10 (64-bit) | Windows 11 (64-bit) |
| **RAM** | 8GB total | 16GB+ total |
| **Storage** | 60GB free space | 100GB+ free space |
| **CPU** | Intel VT-x or AMD-V | Multi-core with virtualization |
| **Admin** | Administrator privileges | Full system control |

---

## 🚀 Installation Methods

ZenzaDae Group OS can be installed in **two ways**:

### 🖥️ **Method 1: Virtual Machine** (Recommended for beginners)
- Runs inside Windows alongside your existing OS
- Safe and reversible installation
- No risk to existing data
- Perfect for testing and development

### 💻 **Method 2: Bare Metal Installation** (Advanced users)
- Installs directly on physical hardware
- Replaces or dual-boots with existing OS
- Maximum performance and hardware access
- **⚠️ WILL ERASE DATA** - backup required!

---

## 🖥️ Method 1: Virtual Machine Installation

### Step 1: Download VirtualBox Portable

1. **Download VirtualBox**: Go to [VirtualBox Downloads](https://www.virtualbox.org/wiki/Downloads)
2. **Get Windows version**: Download "VirtualBox for Windows hosts"
3. **Extract to package**: Extract VirtualBox files to the `VirtualBoxPortable/` folder in this directory

### Step 2: Prepare the VM

**Option A: Build VM from Scripts (Advanced)**
```bash
# Run these scripts in order (requires Arch Linux ISO)
1. Scripts/create_vm.sh          # Creates VirtualBox VM
2. Scripts/arch_install.sh       # Installs Arch Linux (run in VM)
3. Scripts/post_install.sh       # Configures system (run in VM)
4. Scripts/configure_vm.sh       # Applies ZenzaDae branding (run in VM)
```

**Option B: Import Pre-built VM (Recommended)**
- Place `ZenzaDaeGroupOS.ova` file in this directory
- The launcher will automatically import it on first run

### Step 3: Launch ZenzaDae Group OS

1. **Double-click** `ZenzaLauncher.bat`
2. **Wait for import** (first run only - may take 5-10 minutes)
3. **VM boots automatically** in fullscreen mode
4. **Auto-login** as user `zenza` (password: `zenza2025`)

### Step 4: Enable Auto-Startup (Optional)

1. **Right-click** `InstallAsStartup.bat`
2. **Select** "Run as administrator"
3. **Choose option 1** (Current user - recommended)
4. **ZenzaDae OS will now start with Windows**

---

## 📁 Package Structure

```
ZenzaDaeGroupOS/
├── 🚀 ZenzaLauncher.bat          # ← START HERE - Main launcher
├── ⚙️ InstallAsStartup.bat        # Windows auto-startup installer
├── ❌ UninstallZenza.bat          # Remove auto-startup
├── 📖 README.md                   # This installation guide
├── 📋 INSTALLATION_GUIDE.txt      # Detailed instructions
├── 💻 VirtualBoxPortable/         # Extract VirtualBox here
├── 🖥️ ZenzaDaeGroupOS.ova        # VM file (if pre-built)
├── 📜 Scripts/                    # VM building & bare metal scripts
├── 🎨 Branding/                   # Wallpapers and themes
└── 📚 Documentation/              # Complete user manual
```

---

## 🔧 Detailed Installation Steps

### Prerequisites Check

**Before starting, ensure:**
- [ ] You have **administrator privileges** on Windows
- [ ] **Virtualization** is enabled in BIOS/UEFI
- [ ] **Hyper-V is disabled** (Windows Features)
- [ ] **Antivirus is temporarily disabled** (for installation)
- [ ] You have **60GB+ free disk space**

### Installation Process

#### 1. **Prepare VirtualBox Portable**
```
📥 Download: https://www.virtualbox.org/wiki/Downloads
📁 Extract to: ZenzaDaeGroupOS/VirtualBoxPortable/
✅ Verify: VirtualBoxPortable/VBoxManage.exe exists
```

#### 2. **First Launch**
```
🖱️ Double-click: ZenzaLauncher.bat
⏳ Wait: VM import process (5-10 minutes first time)
🖥️ Result: ZenzaDae OS boots in fullscreen
```

#### 3. **Initial Setup** (Inside VM)
```
👤 Login: Automatic (user: zenza, password: zenza2025)
🖥️ Desktop: XFCE with ZenzaDae branding loads
📁 Folders: ~/ZenzaDae/ directory structure ready
🛠️ Tools: Development environment pre-configured
```

#### 4. **Windows Integration** (Optional)
```
🔧 Right-click: InstallAsStartup.bat
🛡️ Run as: Administrator
📋 Choose: Option 1 (Current user recommended)
✅ Result: Auto-starts with Windows login
```

---

## 💻 Method 2: Bare Metal Installation (USB Flash Drive)

> **⚠️ WARNING**: This method will **ERASE ALL DATA** on the target computer. **Backup everything important first!**

### Prerequisites for Bare Metal Installation

| Requirement | Specification |
|-------------|---------------|
| **USB Drive** | 8GB+ capacity (will be erased) |
| **Target Computer** | 64-bit CPU with 4GB+ RAM |
| **UEFI/BIOS** | UEFI preferred, Legacy BIOS supported |
| **Internet** | Required during installation |
| **Backup** | **ALL DATA BACKED UP** |

### Step 1: Create ZenzaDae Installation USB

#### Option A: Use Pre-built ISO (Recommended)
```bash
# 1. Download ZenzaDae OS ISO (when available)
# 2. Use Rufus (Windows) or dd (Linux) to write ISO to USB
# 3. Boot from USB and follow installation wizard
```

#### Option B: Create Custom Arch Linux USB with ZenzaDae Scripts
```bash
# 1. Download Arch Linux ISO
wget https://mirror.rackspace.com/archlinux/iso/latest/archlinux-x86_64.iso

# 2. Create bootable USB (Windows - use Rufus)
# Download Rufus: https://rufus.ie/
# Select Arch Linux ISO and USB drive
# Use GPT partition scheme for UEFI

# 3. Copy ZenzaDae scripts to USB
# Copy Scripts/ folder to USB drive root
```

### Step 2: Prepare Target Computer

#### BIOS/UEFI Settings
```
🔧 Boot Settings:
   • Enable UEFI boot (disable Legacy/CSM if possible)
   • Enable USB boot
   • Disable Secure Boot temporarily
   • Enable Intel VT-x or AMD-V (for development)

🔧 Storage Settings:
   • Set SATA mode to AHCI
   • Enable NVMe if available
```

#### Backup Checklist
- [ ] **Personal files** backed up to external drive/cloud
- [ ] **Software licenses** and installers saved
- [ ] **Important documents** and media backed up
- [ ] **Browser bookmarks** exported
- [ ] **Email and contacts** backed up

### Step 3: Boot from USB

#### Boot Process
```
1. 🔌 Insert ZenzaDae USB into target computer
2. 🔄 Restart computer
3. ⌨️ Press boot key during startup:
   • F12 (Dell, Lenovo)
   • F9 (HP)
   • F8 (Acer)
   • Option (Mac)
4. 📋 Select USB drive from boot menu
5. 🐧 Boot into Arch Linux live environment
```

### Step 4: Install ZenzaDae Group OS

#### Automated Installation (Recommended)
```bash
# 1. Connect to internet
wifi-menu                    # For WiFi
# OR
dhcpcd                      # For Ethernet

# 2. Download and run ZenzaDae installer
curl -O https://raw.githubusercontent.com/zenzadae-group/installer/main/install.sh
chmod +x install.sh
./install.sh

# 3. Follow interactive installer prompts
# - Select target disk
# - Choose partition scheme
# - Set timezone and locale
# - Create user accounts
# - Apply ZenzaDae branding
```

#### Manual Installation (Advanced)
```bash
# 1. Prepare disk
cfdisk /dev/sda             # Create partitions
mkfs.fat -F32 /dev/sda1     # EFI partition (512MB)
mkfs.ext4 /dev/sda2         # Root partition (remaining space)

# 2. Mount filesystems
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

# 3. Install base system
pacstrap /mnt base linux linux-firmware

# 4. Configure system
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

# 5. Run ZenzaDae configuration
# Copy Scripts/arch_install.sh to /mnt/
# Execute inside chroot environment
bash /arch_install.sh

# 6. Install bootloader
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ZenzaDae
grub-mkconfig -o /boot/grub/grub.cfg

# 7. Set passwords and create users
passwd                      # Set root password
useradd -m -G wheel zenza   # Create zenza user
passwd zenza               # Set user password

# 8. Enable services
systemctl enable NetworkManager
systemctl enable lightdm

# 9. Exit and reboot
exit
umount -R /mnt
reboot
```

### Step 5: First Boot Configuration

#### Initial Setup
```bash
# 1. Boot into ZenzaDae Group OS
# 2. Login as zenza user
# 3. Run post-installation configuration

bash ~/Scripts/post_install.sh      # Install software and tools
bash ~/Scripts/xfce_theme.sh        # Apply ZenzaDae branding
bash ~/Scripts/configure_vm.sh      # Set up directories and settings

# 4. Install Lock-In Mode system
bash ~/Scripts/lock_in_system.sh install
```

#### Network Configuration
```bash
# Connect to WiFi
nmcli device wifi list
nmcli device wifi connect "YourWiFi" password "YourPassword"

# Or use GUI
nm-connection-editor
```

### Step 6: Hardware Optimization

#### Graphics Drivers
```bash
# NVIDIA
sudo pacman -S nvidia nvidia-utils

# AMD
sudo pacman -S mesa xf86-video-amdgpu

# Intel
sudo pacman -S mesa xf86-video-intel
```

#### Audio Setup
```bash
# Install audio system
sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol

# Start audio service
systemctl --user enable pulseaudio
```

#### Laptop-Specific
```bash
# Power management
sudo pacman -S tlp
sudo systemctl enable tlp

# Brightness control
sudo pacman -S acpilight
sudo usermod -a -G video zenza

# Touchpad
sudo pacman -S xf86-input-synaptics
```

### Dual Boot Setup (Optional)

#### Preserve Existing OS
```bash
# 1. Shrink existing Windows partition (use GParted Live USB)
# 2. Install ZenzaDae in free space
# 3. Update GRUB to detect Windows

sudo os-prober
sudo grub-mkconfig -o /boot/grub/grub.cfg

# 4. Configure boot order in BIOS
```

### Bare Metal Advantages

| Feature | Benefit |
|---------|---------|
| **Performance** | Direct hardware access, no virtualization overhead |
| **Graphics** | Full GPU acceleration for gaming/graphics work |
| **Storage** | Native NVMe/SSD speeds |
| **Memory** | Use all available RAM |
| **Peripherals** | Full support for all hardware |
| **Power** | Better power management on laptops |

### Bare Metal Disadvantages

| Consideration | Impact |
|---------------|--------|
| **Data Risk** | Can erase existing OS and data |
| **Compatibility** | Hardware may not be fully supported |
| **Complexity** | Requires advanced Linux knowledge |
| **Recovery** | Harder to recover from issues |
| **Dual Boot** | Complex setup with existing OS |

---

## 🔐 Lock-In Mode Setup

ZenzaDae OS includes a powerful **Lock-In Mode** for kiosk-like operation:

### Enable Lock-In Mode
```bash
# Inside the VM terminal
zenzadae-lock-mode enable
```

### What Lock-In Mode Does
- 🚫 **Disables** Alt+Tab, Ctrl+Alt+T, virtual terminals
- 🖥️ **Forces** all applications to run fullscreen
- 🔒 **Restricts** access to Windows host system
- 🎯 **Creates** kiosk-like focused environment

### Toggle Controls
```bash
zenzadae-lock-mode gui      # Graphical toggle dialog
zenzadae-lock-mode status   # Check current status
zenzadae-lock-mode disable  # Disable lock mode
```

---

## 👤 Default Login Credentials

| Account | Username | Password |
|---------|----------|----------|
| **User Account** | `zenza` | `zenza2025` |
| **Root Account** | `root` | `zenzaroot2025` |
| **Auto-login** | ✅ Enabled | (No password needed) |

---

## 🛠️ Pre-installed Software

### Development Tools
- **VS Code** - Full development environment
- **Git** - Version control with GitHub CLI
- **Node.js** - JavaScript runtime with npm/yarn
- **Python** - Python 3 with pip
- **Go** - Go programming language
- **Docker** - Containerization platform

### Applications
- **Firefox/LibreWolf** - Web browsers
- **Discord** - Team communication
- **Thunderbird** - Email client
- **LibreOffice** - Office suite
- **Obsidian** - Note-taking
- **KDENlive** - Video editing
- **VLC** - Media player

### System Tools
- **XFCE Desktop** - Lightweight desktop environment
- **ZSH + Starship** - Enhanced terminal
- **Flameshot** - Screenshot tool
- **Neofetch** - System information
- **UFW Firewall** - Security

---

## 📁 Directory Structure (Inside VM)

```
~/ZenzaDae/
├── Projects/
│   ├── Automation/         # Automation scripts and tools
│   └── Websites/           # Web development projects
├── Media/
│   ├── Branding/          # ZenzaDae brand assets
│   └── Music/             # Audio files
├── Resources/
│   └── Docs/              # Documentation
├── Templates/             # Project templates
└── ZenzaTerminal/         # Terminal configurations
```

---

## 🆘 Troubleshooting

### Virtual Machine Issues

#### **VM Won't Start**
```
🔧 Solution 1: Enable virtualization in BIOS
🔧 Solution 2: Disable Windows Hyper-V
🔧 Solution 3: Run launcher as Administrator
```

#### **Poor Performance**
```
⚡ Increase RAM: VirtualBox → Settings → System → 6-8GB
⚡ Add CPU cores: VirtualBox → Settings → System → 4 cores
⚡ Enable 3D: VirtualBox → Settings → Display → 3D Acceleration
```

#### **Can't Exit Fullscreen**
```
⌨️ Press: Right Ctrl + F (toggles fullscreen)
⌨️ Press: Right Ctrl + Q (quit VM)
🖱️ VirtualBox Menu: View → Fullscreen Mode
```

#### **Lock-In Mode Stuck**
```
🔧 Exit VM: Right Ctrl + Q
🔧 Restart VM: ZenzaLauncher.bat
🔧 Disable: zenzadae-lock-mode disable
```

#### **Shared Folders Not Working**
```
🛠️ Install: sudo pacman -S virtualbox-guest-utils
🔄 Restart: VM
🗂️ Mount: sudo mount -t vboxsf shared /media/shared
```

### Bare Metal Installation Issues

#### **USB Won't Boot**
```
🔧 BIOS Settings: Enable USB boot, disable Secure Boot
🔧 USB Creation: Use Rufus with GPT partition scheme
🔧 Boot Key: Try F12, F9, F8, ESC during startup
🔧 USB Port: Try different USB ports (USB 2.0 vs 3.0)
```

#### **Installation Fails**
```
🌐 Internet: Ensure stable internet connection
💾 Disk Space: Check target disk has enough space (60GB+)
🔧 UEFI/BIOS: Try switching between UEFI and Legacy modes
📱 USB: Create new USB installer, original may be corrupted
```

#### **Hardware Not Detected**
```
🎮 Graphics: Install drivers after first boot
   • NVIDIA: sudo pacman -S nvidia
   • AMD: sudo pacman -S mesa xf86-video-amdgpu
   • Intel: sudo pacman -S mesa xf86-video-intel

🔊 Audio: Configure audio system
   • sudo pacman -S pulseaudio pavucontrol
   • systemctl --user enable pulseaudio

📶 WiFi: Install wireless drivers
   • sudo pacman -S linux-firmware
   • Check: lspci | grep -i wireless
```

#### **Dual Boot Problems**
```
🔧 Windows Missing: Run os-prober and update GRUB
   • sudo pacman -S os-prober
   • sudo os-prober
   • sudo grub-mkconfig -o /boot/grub/grub.cfg

⚠️ Boot Loop: Boot from USB and repair
   • mount /dev/sdaX /mnt
   • arch-chroot /mnt
   • grub-install /dev/sda
   • grub-mkconfig -o /boot/grub/grub.cfg
```

#### **Performance Issues on Hardware**
```
⚡ Graphics: Enable hardware acceleration
🔋 Laptop: Install power management
   • sudo pacman -S tlp
   • sudo systemctl enable tlp
🌡️ Temperature: Monitor CPU temperature
   • sudo pacman -S lm_sensors
   • sensors
```

#### **Recovery Options**
```
🛠️ Boot from USB: Access rescue environment
💾 Chroot Repair: Mount and repair existing installation
   • mount /dev/sdaX /mnt
   • arch-chroot /mnt
   • [perform repairs]

📸 Backup: Create system image before major changes
🔄 Reinstall: Complete reinstallation if recovery fails
```

---

## ⚙️ Advanced Configuration

### VM Performance Tuning
```bash
# Increase VM resources (run on Windows host)
VBoxManage modifyvm "ZenzaDaeGroupOS" --memory 8192    # 8GB RAM
VBoxManage modifyvm "ZenzaDaeGroupOS" --cpus 4         # 4 CPU cores
VBoxManage modifyvm "ZenzaDaeGroupOS" --vram 256       # 256MB VRAM
```

### Custom Branding
```bash
# Replace wallpapers (inside VM)
cp new_wallpaper.jpg ~/ZenzaDae/Media/Branding/
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s ~/ZenzaDae/Media/Branding/new_wallpaper.jpg

# Apply custom theme
bash ~/Scripts/xfce_theme.sh
```

### Security Hardening
```bash
# Configure firewall (inside VM)
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Check lock-in status
zenzadae-lock-mode status
```

---

## 🎨 ZenzaDae Brand Colors

| Color | Hex Code | Usage |
|-------|----------|-------|
| **Royal Purple** | `#7C3AED` | Primary accents, highlights |
| **Deep Twilight** | `#1B1A3F` | Backgrounds, dark elements |
| **Sakura Gold** | `#FFD700` | Important elements, warnings |
| **Mystic Blush** | `#EFCFE3` | Text, subtle accents |

---

## 🔗 Useful Commands

### VM Control (Windows Host)
```batch
ZenzaLauncher.bat              # Start ZenzaDae OS
InstallAsStartup.bat           # Install auto-startup
UninstallZenza.bat             # Remove auto-startup
```

### USB Installer Creation (Linux)
```bash
# Create bootable USB installer
sudo bash Scripts/create_usb_installer.sh

# Manual USB creation with dd
sudo dd if=archlinux.iso of=/dev/sdX bs=4M status=progress
```

### Bare Metal Installation (Boot from USB)
```bash
# Connect to internet
wifi-menu                      # For WiFi
dhcpcd                        # For Ethernet

# Run automated installer
bash /ZenzaDae_Scripts/bare_metal_install.sh

# Manual installation steps
cfdisk /dev/sda               # Partition disk
mkfs.fat -F32 /dev/sda1       # Format EFI partition
mkfs.ext4 /dev/sda2           # Format root partition
mount /dev/sda2 /mnt          # Mount root
pacstrap /mnt base linux      # Install base system
```

### System Control (Inside VM)
```bash
zenzadae-lock-mode enable      # Enable security mode
zenzadae-lock-mode disable     # Disable security mode
zenzadae-lock-mode gui         # Graphical toggle
neofetch                       # System information
~/ZenzaDae/welcome.sh          # Show welcome message
```

### VirtualBox Management
```bash
# List VMs
VBoxManage list vms

# Start VM headless
VBoxManage startvm "ZenzaDaeGroupOS" --type headless

# Take snapshot
VBoxManage snapshot "ZenzaDaeGroupOS" take "CleanInstall"
```

---

## 📞 Support & Resources

### Getting Help
- 📧 **Email**: support@zenzadae.com
- 🐙 **GitHub**: github.com/zenzadae-group
- 📖 **Documentation**: Complete guide in `Documentation/` folder
- 💬 **Community**: ZenzaDae Discord server

### Additional Resources
- 📋 **Full Manual**: `Documentation/ZenzaDae_Group_OS_Complete_Documentation.pdf`
- 🔧 **Technical Guide**: `INSTALLATION_GUIDE.txt`
- 📊 **Project Overview**: `PROJECT_OVERVIEW.md`
- ✅ **Package Validation**: `Scripts/validate_package.sh`

---

## 🎉 Success Checklist

### Virtual Machine Installation
After VM installation, you should have:

- [ ] ✅ ZenzaDae OS boots in fullscreen from Windows
- [ ] ✅ XFCE desktop with ZenzaDae branding
- [ ] ✅ Auto-login as `zenza` user
- [ ] ✅ All development tools accessible
- [ ] ✅ ~/ZenzaDae/ folder structure created
- [ ] ✅ Lock-in mode toggle working
- [ ] ✅ (Optional) Auto-startup with Windows

### Bare Metal Installation
After hardware installation, you should have:

- [ ] ✅ Computer boots directly into ZenzaDae OS
- [ ] ✅ XFCE desktop with ZenzaDae branding loads
- [ ] ✅ Auto-login as `zenza` user works
- [ ] ✅ Hardware properly detected (graphics, audio, WiFi)
- [ ] ✅ All development tools installed and working
- [ ] ✅ ~/ZenzaDae/ folder structure created
- [ ] ✅ Lock-in mode system functional
- [ ] ✅ Network connectivity established
- [ ] ✅ (Optional) Dual-boot menu working if configured

---

## 🏆 Welcome to ZenzaDae Group OS!

Your custom virtual operating system is now ready for use. Enjoy the complete development environment with ZenzaDae branding and security features!

**🚀 Start developing with ZenzaDae Group OS today!**

---

*Developed by ZenzaDae Group | CEO: Rumi Zen | Version 1.1*
