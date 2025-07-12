🐉 ZENZADAE GROUP OS - COMPLETE VIRTUAL OPERATING SYSTEM
========================================================

Version: 1.1
Developed by: ZenzaDae Group
CEO: Rumi Zen

WHAT IS ZENZADAE GROUP OS?
ZenzaDae Group OS is a custom Arch Linux virtual machine that runs fullscreen 
from Windows, providing a complete development environment with ZenzaDae branding.

📦 PACKAGE CONTENTS:
- ZenzaDaeGroupOS.ova         # Virtual machine file
- VirtualBoxPortable/         # Portable VirtualBox (when downloaded)
- ZenzaLauncher.bat          # Main launcher script
- InstallAsStartup.bat       # Windows startup installation
- UninstallZenza.bat         # Remove from startup
- Scripts/                   # Installation and configuration scripts
- Branding/                  # Wallpapers and theme assets
- Documentation/             # Technical documentation

🚀 QUICK START GUIDE:

1. FIRST TIME SETUP:
   - Extract this package to a folder (e.g., C:\ZenzaDaeGroupOS\)
   - Download VirtualBox Portable and extract to VirtualBoxPortable/ folder
   - Double-click ZenzaLauncher.bat to start

2. AUTO-START INSTALLATION:
   - Right-click InstallAsStartup.bat → "Run as administrator"
   - Choose installation option (current user recommended)
   - ZenzaDae OS will now start with Windows

3. UNINSTALLATION:
   - Double-click UninstallZenza.bat to remove auto-start
   - Delete the entire ZenzaDaeGroupOS folder

🔐 LOCK-IN MODE:
ZenzaDae OS includes a "Lock-In Mode" that restricts access to the Windows host:
- Enable/disable from within the VM using: zenzadae-lock-mode
- When enabled, keyboard shortcuts are restricted
- Forces fullscreen operation for kiosk-like experience
- Toggle anytime from the VM terminal or desktop shortcuts

🖥️  SYSTEM REQUIREMENTS:
- Windows 10/11 (64-bit)
- 8GB RAM minimum (4GB allocated to VM)
- 60GB free disk space
- CPU with virtualization support (VT-x/AMD-V)
- VirtualBox 7.0+ (included in package)

👤 DEFAULT LOGIN:
- Username: zenza
- Password: zenza2025
- Auto-login enabled by default

🛠️  INCLUDED SOFTWARE:
- Development: VS Code, Git, Node.js, Python, Go, Docker
- Browsers: Firefox/LibreWolf
- Communication: Discord, Thunderbird
- Media: KDENlive, VLC, Flameshot
- Office: LibreOffice, Obsidian
- System: XFCE desktop with ZenzaDae branding

📁 DIRECTORY STRUCTURE (IN VM):
~/ZenzaDae/
├── Projects/Automation/     # Automation projects
├── Projects/Websites/       # Web development projects
├── Media/Branding/         # ZenzaDae brand assets
├── Media/Music/            # Music and audio files
├── Resources/Docs/         # Documentation
├── Templates/              # Project templates
└── ZenzaTerminal/          # Terminal configurations

🔧 CUSTOMIZATION:
- Wallpapers: ~/ZenzaDae/Media/Branding/
- Theme colors: Royal Purple, Deep Twilight, Sakura Gold, Mystic Blush
- Fonts: Inter, Nunito Sans, Cinzel Decorative, Sacramento
- Lock-In Mode: Toggle with zenzadae-lock-mode command

💡 TIPS:
- Press Host+F (Right Ctrl+F) to toggle fullscreen
- Press Host+Q (Right Ctrl+Q) to quit VM
- Use zenzadae-lock-mode gui for graphical toggle
- VM files are stored in the VirtualBoxPortable folder

🆘 TROUBLESHOOTING:
- If VM won't start: Enable virtualization in BIOS
- If slow performance: Allocate more RAM/CPU cores
- If can't exit fullscreen: Press Right Ctrl+F
- For Lock-In Mode issues: Run zenzadae-lock-mode disable

📞 SUPPORT:
For technical support and updates, visit:
- GitHub: github.com/zenzadae-group
- Email: support@zenzadae.com
- Website: zenzadae.com

🎉 ENJOY YOUR ZENZADAE GROUP OS EXPERIENCE!
