@echo off
REM ZenzaDae Group OS - Windows Startup Installation Script
REM Configures ZenzaDae OS to launch automatically at Windows startup

title ZenzaDae Group OS - Startup Installation

REM Check for administrator privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with administrator privileges...
) else (
    echo.
    echo 🔐 Administrator Privileges Required
    echo ====================================
    echo.
    echo This script needs administrator privileges to modify Windows startup settings.
    echo Please run this script as Administrator.
    echo.
    echo Right-click on this file and select "Run as administrator"
    echo.
    pause
    exit /b 1
)

echo.
echo 🐉 ZenzaDae Group OS - Startup Installation
echo ==========================================
echo.

REM Set script directory
set SCRIPT_DIR=%~dp0
set LAUNCHER_PATH=%SCRIPT_DIR%ZenzaLauncher.bat

REM Check if launcher script exists
if not exist "%LAUNCHER_PATH%" (
    echo ❌ ZenzaLauncher.bat not found!
    echo Please ensure ZenzaLauncher.bat is in the same directory as this script.
    echo.
    pause
    exit /b 1
)

echo 📋 Installation Options:
echo.
echo 1. Install for Current User Only (Recommended)
echo 2. Install for All Users (Requires Admin)
echo 3. Cancel Installation
echo.
set /p choice="Please select an option (1-3): "

if "%choice%"=="1" goto :current_user
if "%choice%"=="2" goto :all_users
if "%choice%"=="3" goto :cancel
echo Invalid choice. Please try again.
goto :start

:current_user
echo.
echo 👤 Installing ZenzaDae Group OS for current user...

REM Add to current user startup registry
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "ZenzaDaeGroupOS" /d "\"%LAUNCHER_PATH%\"" /f >nul

if errorlevel 1 (
    echo ❌ Failed to add startup entry!
    goto :error
)

echo ✅ Successfully installed for current user!
goto :success

:all_users
echo.
echo 👥 Installing ZenzaDae Group OS for all users...

REM Add to local machine startup registry
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "ZenzaDaeGroupOS" /d "\"%LAUNCHER_PATH%\"" /f >nul

if errorlevel 1 (
    echo ❌ Failed to add startup entry for all users!
    goto :error
)

echo ✅ Successfully installed for all users!
goto :success

:success
echo.
echo 🎉 Installation Completed Successfully!
echo ======================================
echo.
echo ZenzaDae Group OS will now launch automatically when Windows starts.
echo.
echo 📋 What happens next:
echo    • ZenzaDae OS will start with Windows
echo    • The VM will launch in fullscreen mode
echo    • Lock-In Mode can be enabled from within the VM
echo.
echo 💡 Useful Information:
echo    • To disable auto-start: Run UninstallZenza.bat
echo    • To manually start: Run ZenzaLauncher.bat
echo    • VM controls: Right Ctrl + F (fullscreen), Right Ctrl + Q (quit)
echo.
echo 🔒 Security Note:
echo    Enable Lock-In Mode from within ZenzaDae OS to restrict
echo    access to Windows host system.
echo.
goto :end

:cancel
echo.
echo ❌ Installation cancelled by user.
goto :end

:error
echo.
echo ❌ Installation failed!
echo.
echo Please try the following:
echo 1. Run this script as Administrator
echo 2. Check if antivirus is blocking registry changes
echo 3. Ensure ZenzaLauncher.bat exists in the same directory
echo.

:end
echo.
pause
exit /b 0
