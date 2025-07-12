# VBoxManage Command Summary

This document provides a summary of the most relevant VBoxManage commands for the ZenzaDae Group OS VM project.

## VM Creation and Configuration

- `VBoxManage createvm`: Creates a new VM.
- `VBoxManage registervm`: Registers an existing VM.
- `VBoxManage modifyvm`: Modifies the properties of a VM (e.g., memory, CPUs, network).
- `VBoxManage storagectl`: Adds and configures storage controllers.
- `VBoxManage storageattach`: Attaches storage media (e.g., VDI, ISO) to a storage controller.

## VM Control

- `VBoxManage startvm`: Starts a VM.
- `VBoxManage controlvm`: Controls a running VM (e.g., pause, resume, poweroff).

## Guest Additions

- `VBoxManage guestproperty`: Manages guest properties, which can be used to communicate with the guest OS.
- `VBoxManage guestcontrol`: Executes commands within the guest OS.

## Import/Export

- `VBoxManage import`: Imports a VM from an OVF/OVA file.
- `VBoxManage export`: Exports a VM to an OVF/OVA file.

## Fullscreen and Display

- `VBoxManage setextradata`: Sets extra data for a VM, which can be used to configure display settings like fullscreen mode.

