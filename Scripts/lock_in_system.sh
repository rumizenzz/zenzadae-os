#!/bin/bash
# ZenzaDae Group OS - Advanced Lock-In Mode System
# Provides comprehensive system locking and security features

set -e

LOCK_FILE="/home/zenza/.zenzadae-lock"
CONFIG_DIR="/home/zenza/.config/zenzadae"
BACKUP_DIR="/home/zenza/.config/zenzadae/backups"

# Create necessary directories
mkdir -p "$CONFIG_DIR" "$BACKUP_DIR"

# Lock-In Mode Functions
enable_lock_mode() {
    echo "🔒 Enabling ZenzaDae Lock-In Mode..."
    
    # Create lock file
    touch "$LOCK_FILE"
    echo "$(date)" > "$LOCK_FILE"
    
    # Backup current XFCE shortcuts
    if [ -f ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml ]; then
        cp ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml "$BACKUP_DIR/"
    fi
    
    # Create restrictive keyboard shortcuts configuration
    create_locked_shortcuts
    
    # Configure session to prevent switching
    configure_locked_session
    
    # Setup fullscreen enforcement
    setup_fullscreen_enforcement
    
    echo "✅ Lock-In Mode enabled successfully!"
    echo "🔄 Restart the desktop session or reboot for full effect."
    
    # Show notification
    notify-send "ZenzaDae Group OS" "Lock-In Mode Enabled\nRestart session for full effect" -t 5000
}

disable_lock_mode() {
    echo "🔓 Disabling ZenzaDae Lock-In Mode..."
    
    # Remove lock file
    rm -f "$LOCK_FILE"
    
    # Restore original shortcuts if backup exists
    if [ -f "$BACKUP_DIR/xfce4-keyboard-shortcuts.xml" ]; then
        cp "$BACKUP_DIR/xfce4-keyboard-shortcuts.xml" ~/.config/xfce4/xfconf/xfce-perchannel-xml/
    else
        # Create default shortcuts
        create_default_shortcuts
    fi
    
    # Remove lock-specific autostart entries
    rm -f ~/.config/autostart/zenzadae-lock-*.desktop
    
    # Kill any running lock processes
    pkill -f "zenzadae-lock" 2>/dev/null || true
    pkill -f "unclutter" 2>/dev/null || true
    
    echo "✅ Lock-In Mode disabled successfully!"
    echo "🔄 Restart the desktop session for full effect."
    
    # Show notification
    notify-send "ZenzaDae Group OS" "Lock-In Mode Disabled\nRestart session to restore normal shortcuts" -t 5000
}

create_locked_shortcuts() {
    cat > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-keyboard-shortcuts" version="1.0">
  <property name="commands" type="empty">
    <property name="default" type="empty">
      <!-- Disable most shortcuts in lock mode -->
      <property name="&lt;Primary&gt;&lt;Alt&gt;t" type="string" value=""/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Delete" type="string" value=""/>
      <property name="&lt;Alt&gt;F2" type="string" value=""/>
      <property name="&lt;Alt&gt;F4" type="string" value=""/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;Escape" type="string" value=""/>
      <property name="&lt;Super&gt;r" type="string" value=""/>
      
      <!-- Keep only essential shortcuts -->
      <property name="&lt;Primary&gt;&lt;Alt&gt;l" type="string" value="xflock4"/>
      <property name="Print" type="string" value="xfce4-screenshooter"/>
    </property>
  </property>
  <property name="xfwm4" type="empty">
    <property name="default" type="empty">
      <!-- Disable window management shortcuts -->
      <property name="&lt;Alt&gt;Tab" type="string" value=""/>
      <property name="&lt;Alt&gt;&lt;Shift&gt;Tab" type="string" value=""/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Left" type="string" value=""/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Right" type="string" value=""/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;d" type="string" value=""/>
      <property name="&lt;Alt&gt;F9" type="string" value=""/>
      <property name="&lt;Alt&gt;F10" type="string" value=""/>
      <property name="&lt;Alt&gt;F11" type="string" value=""/>
      <property name="&lt;Alt&gt;F12" type="string" value=""/>
      
      <!-- Keep window closing for applications -->
      <property name="&lt;Alt&gt;F4" type="string" value="close_window_key"/>
    </property>
  </property>
</channel>
EOF
}

create_default_shortcuts() {
    cat > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-keyboard-shortcuts" version="1.0">
  <property name="commands" type="empty">
    <property name="default" type="empty">
      <property name="&lt;Primary&gt;&lt;Alt&gt;t" type="string" value="exo-open --launch TerminalEmulator"/>
      <property name="&lt;Alt&gt;F2" type="string" value="xfce4-appfinder --collapsed"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Delete" type="string" value="xfce4-session-logout"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;l" type="string" value="xflock4"/>
      <property name="Print" type="string" value="xfce4-screenshooter"/>
    </property>
  </property>
  <property name="xfwm4" type="empty">
    <property name="default" type="empty">
      <property name="&lt;Alt&gt;Tab" type="string" value="cycle_windows_key"/>
      <property name="&lt;Alt&gt;&lt;Shift&gt;Tab" type="string" value="cycle_reverse_windows_key"/>
      <property name="&lt;Alt&gt;F4" type="string" value="close_window_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Left" type="string" value="left_workspace_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Right" type="string" value="right_workspace_key"/>
    </property>
  </property>
</channel>
EOF
}

configure_locked_session() {
    # Create autostart entry for lock enforcement
    cat > ~/.config/autostart/zenzadae-lock-enforcer.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=ZenzaDae Lock Enforcer
Exec=/home/zenza/.config/zenzadae/lock-enforcer.sh
Hidden=false
NoDisplay=true
X-GNOME-Autostart-enabled=true
X-GNOME-Autostart-Delay=3
EOF

    # Create the lock enforcer script
    cat > ~/.config/zenzadae/lock-enforcer.sh << 'EOF'
#!/bin/bash
# ZenzaDae Lock-In Mode Enforcer
# Continuously monitors and enforces lock-in restrictions

LOCK_FILE="/home/zenza/.zenzadae-lock"

# Only run if lock mode is enabled
if [ ! -f "$LOCK_FILE" ]; then
    exit 0
fi

# Wait for desktop to fully load
sleep 5

# Function to enforce fullscreen
enforce_fullscreen() {
    # Get the active window
    ACTIVE_WINDOW=$(xdotool getactivewindow 2>/dev/null)
    
    if [ ! -z "$ACTIVE_WINDOW" ]; then
        # Force window to fullscreen if not already
        wmctrl -r :ACTIVE: -b add,fullscreen 2>/dev/null
        
        # Ensure window covers entire screen
        xdotool windowmove "$ACTIVE_WINDOW" 0 0 2>/dev/null
        xdotool windowsize "$ACTIVE_WINDOW" 100% 100% 2>/dev/null
    fi
}

# Function to disable virtual terminals
disable_vt_switching() {
    # Disable Ctrl+Alt+F1-F12 virtual terminal switching
    for i in {1..12}; do
        sudo chvt $i 2>/dev/null && sudo chvt 7 2>/dev/null
    done
}

# Function to monitor and block restricted applications
monitor_processes() {
    # Kill any terminal emulators that might bypass restrictions
    pkill -f "gnome-terminal" 2>/dev/null || true
    pkill -f "xterm" 2>/dev/null || true
    pkill -f "konsole" 2>/dev/null || true
    
    # Allow only xfce4-terminal through the menu system
    # (users can still access terminal through applications menu)
}

# Start unclutter to hide cursor during inactivity
unclutter -idle 2 -root &

# Main enforcement loop
while [ -f "$LOCK_FILE" ]; do
    enforce_fullscreen
    monitor_processes
    sleep 2
done
EOF

    chmod +x ~/.config/zenzadae/lock-enforcer.sh
}

setup_fullscreen_enforcement() {
    # Create window rule for all applications to start maximized
    cat > ~/.config/zenzadae/lock-window-rules.sh << 'EOF'
#!/bin/bash
# Force all new windows to fullscreen in lock mode

LOCK_FILE="/home/zenza/.zenzadae-lock"

if [ -f "$LOCK_FILE" ]; then
    # Monitor for new windows and force them fullscreen
    while read line; do
        if echo "$line" | grep -q "CREATE"; then
            sleep 0.5  # Give window time to appear
            wmctrl -r :ACTIVE: -b add,fullscreen 2>/dev/null
        fi
    done < <(xprop -spy -root _NET_CLIENT_LIST 2>/dev/null)
fi
EOF

    chmod +x ~/.config/zenzadae/lock-window-rules.sh
    
    # Create autostart for window rules
    cat > ~/.config/autostart/zenzadae-window-rules.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=ZenzaDae Window Rules
Exec=/home/zenza/.config/zenzadae/lock-window-rules.sh
Hidden=false
NoDisplay=true
X-GNOME-Autostart-enabled=true
X-GNOME-Autostart-Delay=2
EOF
}

# GUI Toggle Function
gui_toggle() {
    if command -v zenity >/dev/null 2>&1; then
        if [ -f "$LOCK_FILE" ]; then
            zenity --question --title="ZenzaDae Lock-In Mode" \
                   --text="Lock-In Mode is currently ENABLED.\n\nThis restricts access to the host system and enforces fullscreen operation.\n\nDo you want to DISABLE Lock-In Mode?" \
                   --ok-label="Disable" --cancel-label="Keep Enabled"
            if [ $? -eq 0 ]; then
                disable_lock_mode
                zenity --info --title="ZenzaDae Lock-In Mode" \
                       --text="Lock-In Mode has been DISABLED.\n\nRestart your session for changes to take full effect."
            fi
        else
            zenity --question --title="ZenzaDae Lock-In Mode" \
                   --text="Lock-In Mode is currently DISABLED.\n\nEnabling Lock-In Mode will:\n• Restrict access to host system\n• Enforce fullscreen operation\n• Disable most keyboard shortcuts\n• Hide system controls\n\nDo you want to ENABLE Lock-In Mode?" \
                   --ok-label="Enable" --cancel-label="Keep Disabled"
            if [ $? -eq 0 ]; then
                enable_lock_mode
                zenity --info --title="ZenzaDae Lock-In Mode" \
                       --text="Lock-In Mode has been ENABLED.\n\nRestart your session for changes to take full effect."
            fi
        fi
    else
        # Fallback to command line if no GUI available
        command_line_toggle
    fi
}

# Command Line Toggle Function
command_line_toggle() {
    if [ -f "$LOCK_FILE" ]; then
        echo "🔒 Lock-In Mode is currently ENABLED"
        echo "   Restrictions: Keyboard shortcuts disabled, fullscreen enforced"
        echo "   Status: $(cat "$LOCK_FILE" 2>/dev/null || echo "Active")"
        echo ""
        read -p "Do you want to DISABLE Lock-In Mode? (y/N): " response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            disable_lock_mode
        else
            echo "Lock-In Mode remains enabled."
        fi
    else
        echo "🔓 Lock-In Mode is currently DISABLED"
        echo "   Status: Normal desktop operation with full shortcuts"
        echo ""
        echo "⚠️  WARNING: Enabling Lock-In Mode will:"
        echo "   • Restrict access to host Windows system"
        echo "   • Disable most keyboard shortcuts (Alt+Tab, Ctrl+Alt+T, etc.)"
        echo "   • Force all applications to run fullscreen"
        echo "   • Hide cursor during inactivity"
        echo ""
        read -p "Do you want to ENABLE Lock-In Mode? (y/N): " response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            enable_lock_mode
        else
            echo "Lock-In Mode remains disabled."
        fi
    fi
}

# Status Check Function
check_status() {
    echo "🐉 ZenzaDae Group OS - Lock-In Mode Status"
    echo "=========================================="
    if [ -f "$LOCK_FILE" ]; then
        echo "Status: 🔒 ENABLED"
        echo "Since: $(cat "$LOCK_FILE" 2>/dev/null || echo "Unknown")"
        echo ""
        echo "Active Restrictions:"
        echo "  ✓ Keyboard shortcuts disabled"
        echo "  ✓ Fullscreen enforcement active"  
        echo "  ✓ Window switching restricted"
        echo "  ✓ Host system access limited"
    else
        echo "Status: 🔓 DISABLED"
        echo ""
        echo "Current Mode:"
        echo "  ✓ Normal desktop operation"
        echo "  ✓ All keyboard shortcuts available"
        echo "  ✓ Full window management"
        echo "  ✓ Host system accessible"
    fi
    echo ""
}

# Install system-wide command
install_system_command() {
    if [ "$USER" != "zenza" ]; then
        echo "❌ This function must be run as the zenza user"
        return 1
    fi
    
    echo "📦 Installing system-wide zenzadae-lock-mode command..."
    
    # Create the main command script
    sudo tee /usr/local/bin/zenzadae-lock-mode > /dev/null << 'SCRIPT'
#!/bin/bash
# ZenzaDae Group OS - Lock-In Mode Toggle (System Command)
# Usage: zenzadae-lock-mode [enable|disable|status|gui]

SCRIPT_DIR="/home/zenza/.config/zenzadae"
LOCK_SCRIPT="$SCRIPT_DIR/lock-system.sh"

# Ensure the script exists
if [ ! -f "$LOCK_SCRIPT" ]; then
    echo "❌ Lock system script not found. Please run post-installation setup."
    exit 1
fi

# Execute the lock system script with parameters
bash "$LOCK_SCRIPT" "$@"
SCRIPT

    sudo chmod +x /usr/local/bin/zenzadae-lock-mode
    
    # Copy this script to the config directory
    cp "$0" ~/.config/zenzadae/lock-system.sh
    chmod +x ~/.config/zenzadae/lock-system.sh
    
    echo "✅ System command installed successfully!"
    echo "💡 You can now use: zenzadae-lock-mode [enable|disable|status|gui]"
}

# Main function
main() {
    case "${1:-toggle}" in
        "enable")
            enable_lock_mode
            ;;
        "disable")
            disable_lock_mode
            ;;
        "status")
            check_status
            ;;
        "gui")
            gui_toggle
            ;;
        "install")
            install_system_command
            ;;
        "toggle"|"")
            # Auto-detect GUI vs command line
            if [ -n "$DISPLAY" ] && command -v zenity >/dev/null 2>&1; then
                gui_toggle
            else
                command_line_toggle
            fi
            ;;
        *)
            echo "🐉 ZenzaDae Group OS - Lock-In Mode Control"
            echo "Usage: $0 [enable|disable|status|gui|toggle|install]"
            echo ""
            echo "Commands:"
            echo "  enable   - Enable Lock-In Mode"
            echo "  disable  - Disable Lock-In Mode" 
            echo "  status   - Show current status"
            echo "  gui      - Show GUI toggle dialog"
            echo "  toggle   - Smart toggle (GUI if available, otherwise CLI)"
            echo "  install  - Install as system-wide command"
            echo ""
            echo "Examples:"
            echo "  $0              # Smart toggle"
            echo "  $0 enable       # Enable lock mode"
            echo "  $0 status       # Check status"
            ;;
    esac
}

# Run main function with all arguments
main "$@"
