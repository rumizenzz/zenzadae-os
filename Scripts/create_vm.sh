#!/bin/bash
# ZenzaDae Group OS - VM Creation Script
# Creates and configures the base VirtualBox VM

set -e

VM_NAME="ZenzaDaeGroupOS"
VM_OSTYPE="ArchLinux_64"
VM_MEMORY="4096"
VM_CPUS="2"
VM_DISK_SIZE="51200"  # 50GB in MB
VM_DISK_PATH="./ZenzaDaeGroupOS.vdi"

echo "🐉 Creating ZenzaDae Group OS Virtual Machine..."

# Check if VM already exists
if VBoxManage list vms | grep -q "\"$VM_NAME\""; then
    echo "❌ VM '$VM_NAME' already exists. Please remove it first."
    exit 1
fi

# Create the VM
echo "📦 Creating VM: $VM_NAME"
VBoxManage createvm --name "$VM_NAME" --ostype "$VM_OSTYPE" --register

# Configure VM settings
echo "⚙️  Configuring VM settings..."
VBoxManage modifyvm "$VM_NAME" \
    --memory "$VM_MEMORY" \
    --cpus "$VM_CPUS" \
    --vram 128 \
    --graphicscontroller vboxsvga \
    --accelerate3d on \
    --accelerate2dvideo on \
    --boot1 dvd \
    --boot2 disk \
    --boot3 none \
    --boot4 none \
    --chipset piix3 \
    --ioapic on \
    --pae on \
    --longmode on \
    --hpet on \
    --hwvirtex on \
    --nestedpaging on \
    --largepages on \
    --vtxvpid on \
    --rtcuseutc on

# Network configuration
echo "🌐 Configuring network..."
VBoxManage modifyvm "$VM_NAME" \
    --nic1 nat \
    --nictype1 82540EM \
    --cableconnected1 on

# Audio configuration
echo "🔊 Configuring audio..."
VBoxManage modifyvm "$VM_NAME" \
    --audio pulse \
    --audiocontroller hda \
    --audiocodec stac9221

# USB configuration
echo "🔌 Configuring USB..."
VBoxManage modifyvm "$VM_NAME" \
    --usb on \
    --usbehci on

# Create and attach hard disk
echo "💾 Creating virtual hard disk..."
VBoxManage createhd --filename "$VM_DISK_PATH" --size "$VM_DISK_SIZE" --format VDI

echo "🔗 Attaching storage controllers..."
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VM_DISK_PATH"

VBoxManage storagectl "$VM_NAME" --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach "$VM_NAME" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium emptydrive

# Configure shared folders (for file transfer)
echo "📁 Setting up shared folders..."
mkdir -p "./shared"
VBoxManage sharedfolder add "$VM_NAME" --name "shared" --hostpath "$(pwd)/shared" --automount

# Configure VM for fullscreen operation
echo "🖥️  Configuring display settings..."
VBoxManage setextradata "$VM_NAME" "GUI/Fullscreen" "true"
VBoxManage setextradata "$VM_NAME" "GUI/AutoresizeGuest" "true"
VBoxManage setextradata "$VM_NAME" "GUI/ScaleFactor" "1.0"

echo "✅ VM '$VM_NAME' created successfully!"
echo ""
echo "📋 VM Configuration Summary:"
echo "   Name: $VM_NAME"
echo "   OS Type: $VM_OSTYPE"
echo "   Memory: ${VM_MEMORY}MB"
echo "   CPUs: $VM_CPUS"
echo "   Disk: ${VM_DISK_SIZE}MB"
echo "   Disk Path: $VM_DISK_PATH"
echo ""
echo "🔄 Next Steps:"
echo "   1. Download Arch Linux ISO"
echo "   2. Attach ISO and start installation"
echo "   3. Run automated installation script"
echo ""
echo "💡 To start the VM:"
echo "   VBoxManage startvm \"$VM_NAME\" --type gui"
