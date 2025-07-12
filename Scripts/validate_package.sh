#!/bin/bash
# ZenzaDae Group OS - Package Validation Script
# Validates package integrity and components

echo "🔍 ZenzaDae Group OS - Package Validation"
echo "========================================="

ERRORS=0
WARNINGS=0

# Check core files
echo "📋 Checking core files..."

check_file() {
    if [ -f "$1" ]; then
        echo "  ✅ $1"
    else
        echo "  ❌ MISSING: $1"
        ((ERRORS++))
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo "  ✅ $1/"
    else
        echo "  ⚠️  MISSING DIR: $1/"
        ((WARNINGS++))
    fi
}

# Check Windows scripts
check_file "ZenzaLauncher.bat"
check_file "InstallAsStartup.bat"
check_file "UninstallZenza.bat"
check_file "README.txt"

# Check directories
check_dir "Scripts"
check_dir "Branding"
check_dir "Documentation"

# Check scripts
echo ""
echo "🔧 Checking scripts..."
check_file "Scripts/create_vm.sh"
check_file "Scripts/arch_install.sh"
check_file "Scripts/post_install.sh"
check_file "Scripts/xfce_theme.sh"
check_file "Scripts/lock_in_system.sh"
check_file "Scripts/configure_vm.sh"
check_file "Scripts/create_usb_installer.sh"
check_file "Scripts/bare_metal_install.sh"

# Check branding
echo ""
echo "🎨 Checking branding assets..."
check_dir "Branding/wallpapers"

if [ -d "Branding/wallpapers" ]; then
    WALLPAPER_COUNT=$(find Branding/wallpapers -name "*.jpg" | wc -l)
    if [ $WALLPAPER_COUNT -gt 0 ]; then
        echo "  ✅ Found $WALLPAPER_COUNT wallpaper(s)"
    else
        echo "  ⚠️  No wallpapers found"
        ((WARNINGS++))
    fi
fi

# Check VirtualBox Portable
echo ""
echo "💻 Checking VirtualBox Portable..."
check_dir "VirtualBoxPortable"

if [ ! -f "VirtualBoxPortable/VBoxManage.exe" ]; then
    echo "  ⚠️  VirtualBox Portable not installed"
    echo "     Please download and extract VirtualBox to VirtualBoxPortable/"
    ((WARNINGS++))
fi

# Check VM file
echo ""
echo "🖥️  Checking VM file..."
if [ -f "ZenzaDaeGroupOS.ova" ]; then
    FILE_SIZE=$(stat -f%z "ZenzaDaeGroupOS.ova" 2>/dev/null || stat -c%s "ZenzaDaeGroupOS.ova" 2>/dev/null || echo "0")
    if [ $FILE_SIZE -gt 1000000000 ]; then  # > 1GB
        echo "  ✅ ZenzaDaeGroupOS.ova ($(numfmt --to=iec $FILE_SIZE))"
    else
        echo "  ⚠️  ZenzaDaeGroupOS.ova seems too small"
        ((WARNINGS++))
    fi
else
    echo "  ❌ MISSING: ZenzaDaeGroupOS.ova"
    echo "     VM file not found - build process may have failed"
    ((ERRORS++))
fi

# Summary
echo ""
echo "📊 Validation Summary:"
echo "====================="

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo "✅ Package validation PASSED"
    echo "   All components are present and ready for distribution"
elif [ $ERRORS -eq 0 ]; then
    echo "⚠️  Package validation completed with $WARNINGS warning(s)"
    echo "   Package is functional but some optional components are missing"
else
    echo "❌ Package validation FAILED with $ERRORS error(s) and $WARNINGS warning(s)"
    echo "   Package is incomplete and may not function correctly"
fi

echo ""
echo "📝 Next Steps:"
if [ $ERRORS -eq 0 ]; then
    echo "   1. Download VirtualBox Portable if not present"
    echo "   2. Test ZenzaLauncher.bat functionality"
    echo "   3. Package is ready for distribution"
else
    echo "   1. Fix missing core files and components"
    echo "   2. Re-run validation after corrections"
    echo "   3. Do not distribute until all errors are resolved"
fi

exit $ERRORS
