# Windows-VM Integration Guide

This document provides a guide to integrating the Arch Linux VM with a Windows host.

## 1. Automating VirtualBox from Batch Scripts

- **VBoxManage**: The `VBoxManage` command-line tool is the key to automating VirtualBox from batch scripts. It can be used to start, stop, and control VMs.
- **Example Batch Script**:

```batch
@echo off
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm "Your_VM_Name" --type headless
```

## 2. Windows Startup Integration

- **Startup Folder**: A simple way to launch the VM at startup is to place a batch script in the Windows Startup folder.
- **Task Scheduler**: For more control, the Windows Task Scheduler can be used to create a task that launches the VM at startup.

## 3. Fullscreen Launch

- **`VBoxManage`**: The `VBoxManage` command can be used to set the VM to fullscreen mode.

```batch
@echo off
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm "Your_VM_Name"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm "Your_VM_Name" setvideomodehint 1920 1080 32
```

- **Guest Additions**: The VirtualBox Guest Additions must be installed in the guest OS for seamless fullscreen to work correctly.

## 4. Host-Guest Communication

- **Shared Folders**: Shared folders provide a simple way to share files between the host and the guest.
- **Host-Only Networking**: Host-only networking creates a private network between the host and the guest, allowing for network-based communication (e.g., SSH, VNC).
- **Guest Control**: The `VBoxManage guestcontrol` command can be used to execute commands in the guest OS from the host.
