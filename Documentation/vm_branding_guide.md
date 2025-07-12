# VM Branding and Customization Guide

This document provides a guide to branding and customizing the Arch Linux VM for the ZenzaDae Group OS project.

## 1. Desktop Environment Theming

### XFCE
- **Themes**: XFCE uses GTK themes. Themes can be downloaded from sites like XFCE-Look and placed in `~/.themes` or `/usr/share/themes`.
- **Icons**: Icon themes can be found on the same sites and are placed in `~/.icons` or `/usr/share/icons`.
- **Configuration**: The Appearance application in XFCE is used to apply themes and icons.

### KDE Plasma
- **Global Themes**: KDE offers global themes that include desktop themes, icons, cursors, and more. These can be downloaded from the KDE Store.
- **Plasma Styles**: For more detailed customization, you can create or modify Plasma Styles, which are SVG-based.
- **Configuration**: The System Settings application is used to manage and apply themes.

## 2. Custom Wallpaper and Icons

- **Wallpaper**: Wallpapers can be set via the desktop environment's settings. For scripted deployment, you can copy the wallpaper to a standard location (e.g., `/usr/share/backgrounds`) and set it as the default.
- **Icons**: Custom icons can be packaged into an icon theme or placed in the appropriate icon directories.

## 3. Login Screen Customization

- **LightDM**: The LightDM greeter can be themed. The configuration file is typically located at `/etc/lightdm/lightdm.conf`.
- **SDDM**: SDDM themes are located in `/usr/share/sddm/themes`. The theme can be set in the `/etc/sddm.conf` file.

## 4. Font Installation

- **Command Line**: Fonts can be installed by copying them to `~/.fonts` or `/usr/share/fonts` and then running `fc-cache -f -v` to update the font cache.

## 5. Best Practices

- **Consistency**: Maintain a consistent look and feel across all branded elements.
- **Automation**: Script the deployment of all branding assets (themes, wallpapers, icons, fonts) to ensure a consistent and repeatable process.
- **User Experience**: Ensure that the chosen themes and customizations are not only visually appealing but also provide a good user experience.
