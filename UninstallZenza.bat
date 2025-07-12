@echo off
REM ZenzaDae Group OS - Startup Removal Script
REM Removes ZenzaDae OS from Windows startup

title ZenzaDae Group OS - Startup Removal

echo.
echo 🐉 ZenzaDae Group OS - Startup Removal
echo ======================================
echo.

echo 🔍 Checking current startup configurations...
echo.

REM Check current user startup
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "ZenzaDaeGroupOS" >nul 2>&1
set CURRENT_USER_INSTALLED=%errorlevel%

REM Check all users startup (requires admin to remove)
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "ZenzaDaeGroupOS" >nul 2>&1
set ALL_USERS_INSTALLED=%errorlevel%

REM Display current status
if %CURRENT_USER_INSTALLED% == 0 (
    echo ✅ Found startup entry for current user
) else (
    echo ❌ No startup entry found for current user
)

if %ALL_USERS_INSTALLED% == 0 (
    echo ✅ Found startup entry for all users
) else (
    echo ❌ No startup entry found for all users
)

echo.

REM Check if anything is installed
if %CURRENT_USER_INSTALLED% neq 0 if %ALL_USERS_INSTALLED% neq 0 (
    echo 🎉 ZenzaDae Group OS is not configured to start with Windows.
    echo Nothing to remove.
    echo.
    goto :end
)

echo 📋 Removal Options:
echo.
if %CURRENT_USER_INSTALLED% == 0 echo 1. Remove from Current User startup
if %ALL_USERS_INSTALLED% == 0 echo 2. Remove from All Users startup ^(Requires Admin^)
echo 3. Remove from Both ^(if applicable^)
echo 4. Cancel Removal
echo.
set /p choice="Please select an option (1-4): "

if "%choice%"=="1" goto :remove_current_user
if "%choice%"=="2" goto :remove_all_users
if "%choice%"=="3" goto :remove_both
if "%choice%"=="4" goto :cancel
echo Invalid choice. Please try again.
goto :start

:remove_current_user
echo.
echo 👤 Removing ZenzaDae Group OS from current user startup...

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "ZenzaDaeGroupOS" /f >nul 2>&1

if errorlevel 1 (
    echo ❌ Failed to remove current user startup entry!
    echo The entry may not exist or access was denied.
) else (
    echo ✅ Successfully removed from current user startup!
)
goto :success

:remove_all_users
echo.
echo 👥 Removing ZenzaDae Group OS from all users startup...

REM Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ Administrator privileges required to remove all users startup entry!
    echo Please run this script as Administrator.
    echo.
    goto :end
)

reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "ZenzaDaeGroupOS" /f >nul 2>&1

if errorlevel 1 (
    echo ❌ Failed to remove all users startup entry!
    echo The entry may not exist or access was denied.
) else (
    echo ✅ Successfully removed from all users startup!
)
goto :success

:remove_both
echo.
echo 🔄 Removing ZenzaDae Group OS from both current user and all users startup...

REM Remove current user entry
if %CURRENT_USER_INSTALLED% == 0 (
    echo Removing current user entry...
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "ZenzaDaeGroupOS" /f >nul 2>&1
    if errorlevel 1 (
        echo ⚠️  Warning: Failed to remove current user startup entry
    ) else (
        echo ✅ Removed current user startup entry
    )
)

REM Remove all users entry
if %ALL_USERS_INSTALLED% == 0 (
    REM Check for administrator privileges
    net session >nul 2>&1
    if %errorLevel% neq 0 (
        echo ❌ Administrator privileges required to remove all users startup entry!
        echo Please run this script as Administrator to remove system-wide entry.
    ) else (
        echo Removing all users entry...
        reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "ZenzaDaeGroupOS" /f >nul 2>&1
        if errorlevel 1 (
            echo ⚠️  Warning: Failed to remove all users startup entry
        ) else (
            echo ✅ Removed all users startup entry
        )
    )
)
goto :success

:success
echo.
echo 🎉 Removal Completed!
echo ===================
echo.
echo ZenzaDae Group OS will no longer start automatically with Windows.
echo.
echo 💡 You can still launch ZenzaDae Group OS manually by:
echo    • Running ZenzaLauncher.bat
echo    • Re-installing startup with InstallAsStartup.bat
echo.
echo 📋 What was removed:
if %CURRENT_USER_INSTALLED% == 0 echo    • Current user startup entry
if %ALL_USERS_INSTALLED% == 0 echo    • All users startup entry
echo.
goto :end

:cancel
echo.
echo ❌ Removal cancelled by user.
echo ZenzaDae Group OS startup configuration remains unchanged.
goto :end

:end
echo.
pause
exit /b 0
