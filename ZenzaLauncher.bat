@echo off
REM ZenzaDae Group OS - Main Launcher Script
REM Launches the ZenzaDae VM in fullscreen mode from Windows

title ZenzaDae Group OS Launcher

echo.
echo 🐉 ZenzaDae Group OS Launcher
echo =============================
echo.

REM Set script directory as working directory
cd /d "%~dp0"

REM Check if VirtualBox is available
if not exist "VirtualBoxPortable\VBoxManage.exe" (
    echo ❌ VirtualBox Portable not found!
    echo Please ensure VirtualBoxPortable is in the same directory as this script.
    echo.
    pause
    exit /b 1
)

REM Check if VM file exists
if not exist "ZenzaDaeGroupOS.ova" (
    echo ❌ ZenzaDae Group OS VM file not found!
    echo Please ensure ZenzaDaeGroupOS.ova is in the same directory as this script.
    echo.
    pause
    exit /b 1
)

REM Set VirtualBox portable directory
set VBOX_USER_HOME=%~dp0VirtualBoxPortable\.VirtualBox
set VBOX_MSI_INSTALL_PATH=%~dp0VirtualBoxPortable
set PATH=%~dp0VirtualBoxPortable;%PATH%

echo 🔍 Checking VM status...

REM Check if VM is already imported
VirtualBoxPortable\VBoxManage.exe list vms | findstr "ZenzaDaeGroupOS" >nul
if errorlevel 1 (
    echo 📦 Importing ZenzaDae Group OS VM...
    VirtualBoxPortable\VBoxManage.exe import "ZenzaDaeGroupOS.ova" --vsys 0 --vmname "ZenzaDaeGroupOS"
    if errorlevel 1 (
        echo ❌ Failed to import VM!
        pause
        exit /b 1
    )
    echo ✅ VM imported successfully!
)

REM Check if VM is already running
VirtualBoxPortable\VBoxManage.exe list runningvms | findstr "ZenzaDaeGroupOS" >nul
if not errorlevel 1 (
    echo ⚠️  ZenzaDae Group OS is already running!
    echo Bringing VM window to front...
    REM Try to bring existing VM window to front
    powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::AppActivate('ZenzaDaeGroupOS')"
    goto :end
)

echo 🚀 Starting ZenzaDae Group OS...

REM Configure VM for optimal fullscreen experience
VirtualBoxPortable\VBoxManage.exe modifyvm "ZenzaDaeGroupOS" --vrde off
VirtualBoxPortable\VBoxManage.exe setextradata "ZenzaDaeGroupOS" "GUI/Fullscreen" "true"
VirtualBoxPortable\VBoxManage.exe setextradata "ZenzaDaeGroupOS" "GUI/AutoresizeGuest" "true"
VirtualBoxPortable\VBoxManage.exe setextradata "ZenzaDaeGroupOS" "GUI/Seamless" "false"

REM Start VM in GUI mode
echo 🐉 Launching ZenzaDae Group OS in fullscreen mode...
start "" VirtualBoxPortable\VirtualBox.exe --startvm "ZenzaDaeGroupOS" --fullscreen

REM Wait a moment and try to ensure fullscreen
timeout /t 3 /nobreak >nul

REM Use PowerShell to send F11 key to enter fullscreen if needed
powershell -Command "Start-Sleep -Seconds 5; Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{F11}')"

:end
echo.
echo ✅ ZenzaDae Group OS launch completed!
echo.
echo 💡 Tips:
echo    - Press Host+F to toggle fullscreen
echo    - Press Host+Q to quit the VM
echo    - Host key is Right Ctrl by default
echo.
echo 🔒 Lock-In Mode can be toggled from within the VM
echo    Run 'zenzadae-lock-mode' in terminal
echo.

REM Don't pause automatically - let it close
if "%1"=="--wait" pause

exit /b 0
