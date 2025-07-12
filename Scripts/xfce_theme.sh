#!/bin/bash
# ZenzaDae Group OS - XFCE Theme Configuration Script
# Configures XFCE desktop environment with ZenzaDae branding

set -e

echo "🎨 Configuring ZenzaDae XFCE Theme..."

# Ensure we're running as the zenza user
if [[ $USER != "zenza" ]]; then
   echo "❌ This script must be run as the 'zenza' user"
   exit 1
fi

# Create theme directories
mkdir -p ~/.themes/ZenzaDae
mkdir -p ~/.icons/ZenzaDae
mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml

# Create GTK theme configuration
echo "🖌️  Creating GTK theme..."
cat > ~/.themes/ZenzaDae/gtk-3.0.css << 'EOF'
/* ZenzaDae Group OS GTK Theme */

/* Royal Purple: #7C3AED */
/* Deep Twilight: #1B1A3F */
/* Sakura Gold: #FFD700 */
/* Mystic Blush: #EFCFE3 */

/* Window decorations */
.window-frame {
    background-color: #1B1A3F;
    border: 2px solid #7C3AED;
}

/* Buttons */
button {
    background: linear-gradient(135deg, #7C3AED, #1B1A3F);
    color: #EFCFE3;
    border: 1px solid #FFD700;
    border-radius: 8px;
    padding: 8px 16px;
    font-weight: bold;
}

button:hover {
    background: linear-gradient(135deg, #8B5CF6, #2D1B69);
    border-color: #FFD700;
    box-shadow: 0 0 10px rgba(255, 215, 0, 0.3);
}

button:active {
    background: linear-gradient(135deg, #6D28D9, #1B1A3F);
}

/* Menu items */
menuitem {
    background-color: #1B1A3F;
    color: #EFCFE3;
}

menuitem:hover {
    background-color: #7C3AED;
    color: #FFD700;
}

/* Panel styling */
.panel {
    background-color: rgba(27, 26, 63, 0.95);
    color: #EFCFE3;
    border-bottom: 2px solid #7C3AED;
}

/* Workspace switcher */
.workspace-switcher {
    background-color: #1B1A3F;
    border: 1px solid #7C3AED;
}

/* Terminal */
.terminal {
    background-color: #1B1A3F;
    color: #EFCFE3;
    font-family: 'Cascadia Code', 'Fira Code', monospace;
}

/* Scrollbars */
scrollbar {
    background-color: #1B1A3F;
}

scrollbar slider {
    background-color: #7C3AED;
    border-radius: 10px;
}

scrollbar slider:hover {
    background-color: #8B5CF6;
}

/* Entry fields */
entry {
    background-color: #1B1A3F;
    color: #EFCFE3;
    border: 2px solid #7C3AED;
    border-radius: 6px;
    padding: 8px;
}

entry:focus {
    border-color: #FFD700;
    box-shadow: 0 0 8px rgba(255, 215, 0, 0.4);
}

/* Tooltips */
tooltip {
    background-color: #1B1A3F;
    color: #FFD700;
    border: 1px solid #7C3AED;
    border-radius: 6px;
}
EOF

# Configure XFCE window manager theme
echo "🪟 Configuring window manager..."
cat > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfwm4" version="1.0">
  <property name="general" type="empty">
    <property name="theme" type="string" value="Default"/>
    <property name="title_font" type="string" value="Inter Bold 11"/>
    <property name="use_compositing" type="bool" value="true"/>
    <property name="frame_opacity" type="int" value="95"/>
    <property name="inactive_opacity" type="int" value="85"/>
    <property name="popup_opacity" type="int" value="95"/>
    <property name="show_frame_shadow" type="bool" value="true"/>
    <property name="show_popup_shadow" type="bool" value="true"/>
    <property name="shadow_delta_height" type="int" value="2"/>
    <property name="shadow_delta_width" type="int" value="0"/>
    <property name="shadow_delta_x" type="int" value="0"/>
    <property name="shadow_delta_y" type="int" value="-10"/>
    <property name="shadow_opacity" type="int" value="50"/>
    <property name="titleless_maximize" type="bool" value="true"/>
    <property name="button_layout" type="string" value="O|SHMC"/>
  </property>
</channel>
EOF

# Configure XFCE panel
echo "📋 Configuring panel..."
cat > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-panel" version="1.0">
  <property name="configver" type="int" value="2"/>
  <property name="panels" type="array">
    <value type="int" value="1"/>
    <property name="panel-1" type="empty">
      <property name="position" type="string" value="p=6;x=0;y=0"/>
      <property name="length" type="uint" value="100"/>
      <property name="position-locked" type="bool" value="true"/>
      <property name="size" type="uint" value="40"/>
      <property name="plugin-ids" type="array">
        <value type="int" value="1"/>
        <value type="int" value="2"/>
        <value type="int" value="3"/>
        <value type="int" value="4"/>
        <value type="int" value="5"/>
        <value type="int" value="6"/>
        <value type="int" value="7"/>
      </property>
      <property name="background-style" type="uint" value="1"/>
      <property name="background-rgba" type="array">
        <value type="double" value="0.106667"/>
        <value type="double" value="0.101961"/>
        <value type="double" value="0.247059"/>
        <value type="double" value="0.950000"/>
      </property>
    </property>
  </property>
  <property name="plugins" type="empty">
    <property name="plugin-1" type="string" value="applicationsmenu"/>
    <property name="plugin-2" type="string" value="tasklist"/>
    <property name="plugin-3" type="string" value="separator"/>
    <property name="plugin-4" type="string" value="pager"/>
    <property name="plugin-5" type="string" value="separator"/>
    <property name="plugin-6" type="string" value="systray"/>
    <property name="plugin-7" type="string" value="clock"/>
  </property>
</channel>
EOF

# Configure desktop settings
echo "🖥️  Configuring desktop..."
cat > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-desktop" version="1.0">
  <property name="backdrop" type="empty">
    <property name="screen0" type="empty">
      <property name="monitorVirtual1" type="empty">
        <property name="workspace0" type="empty">
          <property name="color-style" type="int" value="0"/>
          <property name="image-style" type="int" value="5"/>
          <property name="last-image" type="string" value="/home/zenza/ZenzaDae/Media/Branding/wallpaper.jpg"/>
        </property>
        <property name="workspace1" type="empty">
          <property name="color-style" type="int" value="0"/>
          <property name="image-style" type="int" value="5"/>
          <property name="last-image" type="string" value="/home/zenza/ZenzaDae/Media/Branding/wallpaper.jpg"/>
        </property>
      </property>
    </property>
  </property>
  <property name="desktop-icons" type="empty">
    <property name="style" type="int" value="2"/>
    <property name="use-custom-font-size" type="bool" value="true"/>
    <property name="font-size" type="double" value="12.000000"/>
  </property>
</channel>
EOF

# Configure terminal colors
echo "💻 Configuring terminal colors..."
mkdir -p ~/.config/xfce4/terminal
cat > ~/.config/xfce4/terminal/terminalrc << 'EOF'
[Configuration]
FontName=Cascadia Code 12
MiscAlwaysShowTabs=FALSE
MiscBell=FALSE
MiscBellUrgent=FALSE
MiscBordersDefault=TRUE
MiscCursorBlinks=FALSE
MiscCursorShape=TERMINAL_CURSOR_SHAPE_BLOCK
MiscDefaultGeometry=80x24
MiscInheritGeometry=FALSE
MiscMenubarDefault=FALSE
MiscMouseAutohide=FALSE
MiscMouseWheelZoom=TRUE
MiscToolbarDefault=FALSE
MiscConfirmClose=TRUE
MiscCycleTabs=TRUE
MiscTabCloseButtons=TRUE
MiscTabCloseMiddleClick=TRUE
MiscTabPosition=GTK_POS_TOP
MiscHighlightUrls=TRUE
MiscMiddleClickOpensUri=FALSE
MiscCopyOnSelect=FALSE
MiscShowRelaunchDialog=TRUE
MiscRewrapOnResize=TRUE
MiscUseShiftArrowsToSelect=FALSE
MiscSlimTabs=FALSE
MiscNewTabAdjacent=FALSE
MiscSearchDialogOpacity=100
MiscShowUnsafePasteDialog=FALSE
ColorForeground=#efcfe3
ColorBackground=#1b1a3f
ColorCursor=#ffd700
ColorPalette=#1b1a3f;#ff6b9d;#7c3aed;#ffd700;#00d4ff;#ff6bcb;#7c3aed;#efcfe3;#2d1b69;#ff8fab;#8b5cf6;#ffe55c;#33d9ff;#ff8fd9;#9f7aea;#ffffff
TabActivityColor=#ffd700
EOF

# Create application menu customization
echo "📱 Configuring application menu..."
mkdir -p ~/.config/menus
cat > ~/.config/menus/xfce-applications.menu << 'EOF'
<!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
  "http://www.freedesktop.org/standards/menu-spec/menu-1.0.dtd">

<Menu>
    <Name>Xfce</Name>

    <DefaultAppDirs/>
    <DefaultDirectoryDirs/>

    <Include>
        <Category>X-Xfce-Toplevel</Category>
    </Include>

    <Layout>
        <Menuname>ZenzaDae</Menuname>
        <Separator/>
        <Menuname>Development</Menuname>
        <Menuname>Office</Menuname>
        <Menuname>Graphics</Menuname>
        <Menuname>Multimedia</Menuname>
        <Menuname>Network</Menuname>
        <Menuname>System</Menuname>
        <Separator/>
        <Menuname>Settings</Menuname>
    </Layout>

    <Menu>
        <Name>ZenzaDae</Name>
        <Directory>zenzadae.directory</Directory>
        <Include>
            <Filename>code.desktop</Filename>
            <Filename>firefox.desktop</Filename>
            <Filename>discord.desktop</Filename>
            <Filename>thunar.desktop</Filename>
        </Include>
    </Menu>

</Menu>
EOF

# Configure notification theme
echo "🔔 Configuring notifications..."
mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml
cat > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-notifyd.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-notifyd" version="1.0">
  <property name="theme" type="string" value="Default"/>
  <property name="notify-location" type="uint" value="3"/>
  <property name="log-level" type="uint" value="1"/>
  <property name="log-level-apps" type="uint" value="1"/>
  <property name="initial-opacity" type="double" value="0.9"/>
  <property name="fade-transparent" type="bool" value="true"/>
</channel>
EOF

echo "✅ XFCE theme configuration completed!"
echo ""
echo "📋 Theme Configuration Summary:"
echo "   ✓ GTK theme configured with ZenzaDae colors"
echo "   ✓ Window manager styling applied"
echo "   ✓ Panel configured with brand colors"
echo "   ✓ Desktop wallpaper settings configured"
echo "   ✓ Terminal color scheme applied"
echo "   ✓ Application menu customized"
echo "   ✓ Notification theme configured"
echo ""
echo "🔄 Next Steps:"
echo "   1. Restart XFCE session or reboot"
echo "   2. Copy wallpapers to ~/ZenzaDae/Media/Branding/"
echo "   3. Verify theme is applied correctly"
echo ""
echo "💡 To reload XFCE settings:"
echo "   xfce4-panel --restart"
echo "   xfdesktop --reload"
