# ZenzaDae Group OS - Complete User and Technical Documentation

---

## 1. Executive Summary

### 1.1. Product Overview and Value Proposition

ZenzaDae Group OS is a custom-built, pre-configured Arch Linux virtual machine designed for developers and teams who require a consistent, powerful, and secure development environment. It runs fullscreen from a Windows host, providing a seamless and immersive Linux experience without the need for a dual-boot setup. The OS is designed to be portable, allowing developers to take their complete development environment with them on a USB drive.

### 1.2. Key Features and Capabilities

- **Branded XFCE Desktop**: A visually appealing and lightweight desktop environment, themed with ZenzaDae's branding.
- **Complete Development Environment**: Pre-installed with a comprehensive suite of development tools, including VS Code, Git, Node.js, Python, Go, and Docker.
- **Lock-In Mode**: A security feature that transforms the OS into a restricted, kiosk-like environment, ideal for specific tasks or secure operations.
- **Seamless Windows Integration**: Automatically starts up with Windows and runs in a fullscreen, immersive mode.
- **Portable VirtualBox Deployment**: The entire OS and its settings can be run from a portable VirtualBox instance, making it easy to use on different Windows machines.

### 1.3. Target Audience and Use Cases

- **Developers**: A ready-to-use development environment with all the necessary tools and configurations.
- **Teams**: A standardized development environment that ensures consistency across all team members.
- **System Administrators**: A secure, locked-down environment for specific applications or user access.
- **Students and Educators**: A portable and pre-configured Linux environment for learning and teaching.

### 1.4. System Requirements and Compatibility

- **Host OS**: Windows 10 or later
- **Virtualization**: Intel VT-x or AMD-V enabled in the BIOS
- **RAM**: 8GB or more recommended
- **Disk Space**: 60GB of free disk space

---

## 2. Installation Guide

### 2.1. Pre-installation Requirements and Checklist

- **VirtualBox Portable**: Download and extract the latest version of VirtualBox Portable.
- **ZenzaDae Group OS Package**: Download the ZenzaDae Group OS package, which includes the VM files and installation scripts.
- **Windows Host**: Ensure your Windows host meets the system requirements.

### 2.2. Step-by-Step Installation Process

1.  **Launch VirtualBox Portable**: Run the `VirtualBox.exe` from the VirtualBox Portable directory.
2.  **Import the VM**: Go to `File > Import Appliance` and select the `ZenzaDaeGroupOS.ova` file from the ZenzaDae Group OS package.
3.  **Start the VM**: Once the import is complete, select the `ZenzaDaeGroupOS` VM and click `Start`.

### 2.3. VirtualBox Portable Setup Instructions

- **Configuration**: The provided `ZenzaDaeGroupOS.ova` is pre-configured to work with VirtualBox Portable. No special setup is required.

### 2.4. First-Time Configuration Procedures

- **User Account**: The default username is `zenza` and the password is `zenza2025`.
- **Welcome Script**: A welcome script will run on the first login, providing an overview of the system and available commands.

### 2.5. Auto-startup Installation and Configuration

1.  **Open the Startup Folder**: Press `Win + R`, type `shell:startup`, and press Enter.
2.  **Copy the Launcher**: Copy the `ZenzaLauncher.bat` file from the ZenzaDae Group OS package to the Startup folder.

---

## 3. User Manual

### 3.1. Daily Usage Instructions and Workflows

- **Launching the OS**: The OS will launch automatically with Windows if the auto-startup is configured. Otherwise, you can launch it by running `ZenzaLauncher.bat`.
- **Development Workflow**: The `~/ZenzaDae/Projects` directory is the recommended location for all your development projects.
- **Lock-In Mode**: To enter Lock-In Mode, double-click the `Toggle Lock-In Mode` desktop shortcut.

### 3.2. Desktop Environment Navigation (XFCE)

- **Applications Menu**: The main menu is located at the top-left of the screen.
- **Dock**: The dock at the bottom of the screen provides quick access to frequently used applications.
- **Workspaces**: You can switch between workspaces using the workspace switcher in the bottom-right of the screen.

### 3.3. Pre-installed Software and Tools Overview

- **Development**: VS Code, Git, Node.js, Python, Go, Docker
- **Web Browsing**: Firefox, LibreWolf
- **Communication**: Discord, Thunderbird
- **Multimedia**: Kdenlive, VLC
- **Utilities**: Flameshot, GParted, ufw, Redshift

### 3.4. File System Organization and Directory Structure

- `~/ZenzaDae`: The main directory for all your personal files and projects.
- `~/ZenzaDae/Projects`: For your development projects.
- `~/ZenzaDae/Media`: For branding assets, music, and other media.
- `~/ZenzaDae/Resources`: For documentation and other resources.

### 3.5. Lock-In Mode Operation and Controls

- **Toggle**: Use the `Toggle Lock-In Mode` desktop shortcut to enable or disable Lock-In Mode.
- **Restrictions**: In Lock-In Mode, the OS is restricted to a single application, and most keyboard shortcuts are disabled.

---

## 4. Developer Guide

### 4.1. Development Environment Setup and Customization

- **VS Code**: VS Code is pre-configured with a dark theme and a set of useful extensions.
- **Git**: Git is pre-configured with a default user. You should configure it with your own name and email address.
- **Node.js**: NVM is used to manage Node.js versions.

### 4.2. Pre-configured Tools and Extensions

- **VS Code Extensions**: Python, Remote - Containers, and more.
- **Shell**: Zsh with Starship for a powerful and visually appealing command-line experience.

### 4.3. Git Configuration and Workflow

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 4.4. Docker Containerization Setup

- **Docker**: Docker is pre-installed and ready to use. The `zenza` user is a member of the `docker` group, so you can run Docker commands without `sudo`.

### 4.5. Project Organization in ZenzaDae Directories

- **`~/ZenzaDae/Projects`**: Create subdirectories for each of your projects in this folder.

---

## 5. Security and Lock-In Mode

### 5.1. Lock-In Mode Features and Functionality

- **Single Application Mode**: Restricts the OS to a single, fullscreen application.
- **Disabled Shortcuts**: Disables keyboard shortcuts that could be used to escape the kiosk mode.
- **Hidden Cursor**: The cursor is automatically hidden after a period of inactivity.

### 5.2. Security Restrictions and Limitations

- **Firewall**: A firewall is enabled by default to restrict network access.
- **Limited User Privileges**: The `zenza` user has limited privileges to prevent system-wide changes.

### 5.3. Toggle Controls and Management

- **Desktop Shortcut**: The `Toggle Lock-In Mode` desktop shortcut is the primary way to manage Lock-In Mode.
- **Command Line**: You can also use the `zenzadae-lock-mode` command in the terminal.

### 5.4. Troubleshooting Lock-in Issues

- **Stuck in Lock-In Mode**: If you get stuck in Lock-In Mode, you can reboot the VM to disable it.

### 5.5. Best Practices for Secure Operation

- **Keep the System Updated**: Regularly run `sudo pacman -Syu` to keep the system and all packages up to date.
- **Use Strong Passwords**: Change the default passwords for the `zenza` and `root` users.

---

## 6. Customization and Branding

### 6.1. Theme Customization Procedures

- **Appearance Application**: The `Appearance` application in XFCE can be used to change the theme, icons, and fonts.

### 6.2. Wallpaper and Visual Asset Management

- **Wallpaper**: To change the wallpaper, right-click on the desktop and select `Desktop Settings`.
- **Branding Assets**: Custom branding assets can be placed in the `~/ZenzaDae/Media/Branding` directory.

### 6.3. Color Scheme and Font Configuration

- **XFCE Settings**: The color scheme and fonts can be configured in the `Appearance` and `Window Manager` settings.

### 6.4. XFCE Desktop Personalization

- **Panels**: You can add, remove, and customize panels to suit your workflow.
- **Applets**: Add applets to the panels to extend their functionality.

### 6.5. Custom Shortcut and Menu Setup

- **Keyboard Shortcuts**: Custom keyboard shortcuts can be configured in the `Keyboard` settings.
- **Menu Editor**: The `Menu Editor` can be used to customize the applications menu.

---

## 7. Technical Reference

### 7.1. VM Specifications and Configuration

- **OS**: Arch Linux (64-bit)
- **Desktop Environment**: XFCE 4.18
- **Memory**: 4096MB
- **CPUs**: 2
- **Disk Size**: 50GB

### 7.2. VirtualBox Settings and Optimization

- **Graphics Controller**: VBoxSVGA with 3D acceleration enabled.
- **Guest Additions**: VirtualBox Guest Additions are pre-installed for optimal performance.

### 7.3. Network and Storage Configuration

- **Network**: NAT for internet access and a host-only adapter for host-guest communication.
- **Storage**: A single VDI disk with an ext4 filesystem.

### 7.4. Performance Tuning Recommendations

- **Memory**: Increase the VM's memory if you are running memory-intensive applications.
- **CPUs**: Increase the number of CPUs if you are running CPU-intensive applications.

### 7.5. System Administration Tasks

- **Updating the System**: `sudo pacman -Syu`
- **Installing Packages**: `sudo pacman -S <package_name>`
- **Managing Services**: `sudo systemctl [start|stop|enable|disable] <service_name>`

---

## 8. Troubleshooting

### 8.1. Common Issues and Solutions

- **VM Not Starting**: Ensure that virtualization is enabled in your BIOS.
- **No Internet Connection**: Check the network settings in VirtualBox.

### 8.2. Performance Optimization Tips

- **Close Unused Applications**: Close any applications that you are not using to free up resources.
- **Disable Visual Effects**: Disable visual effects in XFCE to improve performance.

### 8.3. Error Diagnosis and Resolution

- **`dmesg`**: Use the `dmesg` command to view kernel messages.
- **`journalctl`**: Use the `journalctl` command to view system logs.

### 8.4. Recovery Procedures

- **Snapshots**: Use VirtualBox snapshots to create restore points for your VM.

### 8.5. Support Resources and Contacts

- **ZenzaDae Group**: For support, please contact the ZenzaDae Group at support@zenzadae.com.

---

## 9. Advanced Configuration

### 9.1. Manual VM Building Procedures

- **Scripts**: The `vm_scripts` directory contains the scripts used to build the VM from scratch.

### 9.2. Script Customization and Modification

- **`arch_install.sh`**: This script can be modified to change the installed packages and system configuration.
- **`post_install.sh`**: This script can be modified to customize the development environment and branding.

### 9.3. Security Hardening Options

- **`vm_security_guide.md`**: This document provides detailed information on security hardening.

### 9.4. Integration with External Systems

- **Host-Only Networking**: Use host-only networking to connect the VM to other systems on the same host.

### 9.5. Backup and Restore Procedures

- **Export Appliance**: Use the `File > Export Appliance` option in VirtualBox to create a backup of the VM.
- **Snapshots**: Use snapshots to create restore points.

---

## 10. Appendices

### 10.1. Command Reference and Shortcuts

- `zenzadae-lock-mode`: Toggles Lock-In Mode.
- `~/ZenzaDae/welcome.sh`: Displays the welcome message.

### 10.2. File and Directory References

- `~/ZenzaDae`: Main user directory.
- `/etc/lightdm/lightdm.conf`: LightDM configuration file.
- `/etc/sddm.conf`: SDDM configuration file.

### 10.3. Color Codes and Branding Specifications

- **Primary Color**: #4D4D4D (ZenzaDae Gray)
- **Secondary Color**: #FFFFFF (White)

### 10.4. Version History and Changelog

- **v1.0.0 (2025-07-12)**: Initial release.

### 10.5. Legal Information and Licenses

- **ZenzaDae Group OS**: This software is provided "as is" without warranty of any kind. See the `LICENSE` file for more information.
- **Third-Party Software**: This software includes third-party software. See the `LICENSES` directory for more information.

