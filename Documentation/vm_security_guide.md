# VM Security and Lock-In Mode Guide

This document provides a guide to securing the Arch Linux VM and implementing a lock-in mode for the ZenzaDae Group OS project.

## 1. VM Security Hardening

- **Minimal Installation**: Start with a minimal Arch Linux installation and only install the necessary packages.
- **Firewall**: Configure a firewall (e.g., ufw) to restrict network access.
- **Regular Updates**: Keep the system and all packages up to date.
- **User Accounts**: Create a dedicated user account with limited privileges for running the kiosk mode.

## 2. Restricting Host Access

- **Network Isolation**: Use a host-only or internal network to isolate the VM from the host's network.
- **Disable Shared Folders**: If not required, disable shared folders to prevent file transfer between the host and guest.
- **Disable USB Passthrough**: Disable USB passthrough to prevent access to host USB devices.

## 3. Kiosk Mode

- **Dedicated Kiosk User**: Create a dedicated user for the kiosk mode.
- **Custom Session**: Create a custom Xsession that only launches the desired application.
- **Window Manager**: Use a lightweight window manager (e.g., Openbox) and configure it to run the application in fullscreen mode.
- **Disable Keyboard Shortcuts**: Disable all keyboard shortcuts that could be used to escape the kiosk mode (e.g., Alt+F4, Ctrl+Alt+Delete).

## 4. User Session Management

- **`limits.conf`**: Use the `/etc/security/limits.conf` file to set limits on user sessions, such as the maximum number of concurrent logins.
- **`pam_limits`**: The `pam_limits` module can be used to enforce these limits.

## 5. Preventing VM Escape

- **Keep VirtualBox Updated**: Use the latest version of VirtualBox to ensure you have the latest security patches.
- **Disable Unnecessary Features**: Disable any VirtualBox features that are not required, such as the shared clipboard and drag and drop.
- **Guest Additions**: Be aware that some features of the Guest Additions (e.g., shared folders, seamless mode) can increase the attack surface.
