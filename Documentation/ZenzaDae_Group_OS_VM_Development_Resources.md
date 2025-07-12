# ZenzaDae Group OS VM Development Resources

This document provides a summary of the research and resources gathered for the ZenzaDae Group OS VM development project. The following sections provide an overview of the key findings and links to the detailed guides for each research area.

## 1. Arch Linux VM Creation & Automation

- **Key Findings**: The `archinstall` library is the recommended tool for automated Arch Linux installations. It can be used as a Python library to create fully unattended installation scripts.
- **Guide**: [Arch Linux VM Creation & Automation Guide](docs/arch_linux_vm_guide.md)

## 2. VirtualBox Advanced Configuration

- **Key Findings**: The `VBoxManage` command-line tool provides complete control over VirtualBox, allowing for the creation, configuration, and management of VMs from scripts.
- **Guide**: [VBoxManage Command Summary](docs/vboxmanage_summary.md)

## 3. VM Branding & Customization

- **Key Findings**: XFCE and KDE Plasma are both highly customizable desktop environments. Themes, icons, wallpapers, and login screens can all be customized to create a branded experience.
- **Guide**: [VM Branding and Customization Guide](docs/vm_branding_guide.md)

## 4. Windows-VM Integration

- **Key Findings**: VirtualBox can be easily integrated with Windows using batch scripts and the Windows Task Scheduler. Host-guest communication can be achieved through shared folders or host-only networking.
- **Guide**: [Windows-VM Integration Guide](docs/windows_vm_integration_guide.md)

## 5. Security & Lock-In Mode Implementation

- **Key Findings**: A secure kiosk mode can be created by using a dedicated user account, a custom Xsession, and a lightweight window manager. It is also important to harden the VM and restrict access to the host system.
- **Guide**: [VM Security and Lock-In Mode Guide](docs/vm_security_guide.md)

## 6. Development Tools & Software Packaging

- **Key Findings**: The installation and configuration of development tools can be automated using `pacman` scripts. VS Code can be customized with extensions and a pre-configured `settings.json` file.
- **Guide**: [Development Tools and Software Packaging Guide](docs/dev_tools_guide.md)
