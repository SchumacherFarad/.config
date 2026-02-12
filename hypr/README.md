# Hyprland Modular Configuration

This is your Hyprland configuration split into organized, modular files for easy maintenance.

## 📁 File Structure

```
~/.config/hypr/
├── hyprland.conf          # Main config (sources all other files)
├── monitors.conf          # Monitor/display configuration
├── programs.conf          # Default applications
├── autostart.conf         # Startup applications
├── environment.conf       # Environment variables
├── look-and-feel.conf     # Visual settings (borders, animations, blur, etc.)
├── input.conf             # Keyboard, mouse, touchpad settings
├── keybindings.conf       # All keyboard shortcuts and mouse bindings
├── window-rules.conf      # Application-specific window rules
└── workspace-rules.conf   # Workspace-specific rules
```

## 🚀 Installation

1. **Backup your current config:**
   ```bash
   cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.backup
   ```

2. **Copy all files to your Hyprland config directory:**
   ```bash
   cp *.conf ~/.config/hypr/
   ```

3. **Reload Hyprland:**
   Press `SUPER + SHIFT + R` or run:
   ```bash
   hyprctl reload
   ```

## 📝 Customization Guide

### Monitors (`monitors.conf`)
Configure your displays here. Examples:
```
monitor = DP-1,1920x1080@144,0x0,1
monitor = HDMI-A-1,1920x1080@60,1920x0,1
```

### Programs (`programs.conf`)
Change your default applications:
```
$terminal = alacritty
$fileManager = thunar
$menu = wofi --show drun
```

### Autostart (`autostart.conf`)
Add applications to launch on startup:
```
exec-once = waybar &
exec-once = dunst &
exec-once = nm-applet &
```

### Look and Feel (`look-and-feel.conf`)
Customize:
- Gaps and borders
- Colors and opacity
- Animations
- Blur effects
- Shadows

### Keybindings (`keybindings.conf`)
All shortcuts are organized by category:
- Application launchers
- Window management
- Focus movement
- Workspace switching
- Media keys

### Window Rules (`window-rules.conf`)
Add application-specific behaviors:
```
windowrule {
    name = float-calculator
    match:class = gnome-calculator
    float = yes
}
```

## 🎨 Quick Tweaks

**Change border colors:**
Edit `look-and-feel.conf`:
```
col.active_border = rgba(ff0000ee)    # Red
col.inactive_border = rgba(333333aa)  # Dark gray
```

**Adjust gaps:**
Edit `look-and-feel.conf`:
```
gaps_in = 10
gaps_out = 30
```

**Disable animations:**
Edit `look-and-feel.conf`:
```
animations {
    enabled = no
}
```

## 🔧 Troubleshooting

If Hyprland doesn't start after applying the config:

1. Check for syntax errors:
   ```bash
   hyprctl reload
   ```

2. View logs:
   ```bash
   cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log
   ```

3. Restore backup:
   ```bash
   cp ~/.config/hypr/hyprland.conf.backup ~/.config/hypr/hyprland.conf
   ```

## 📚 Resources

- [Hyprland Wiki](https://wiki.hypr.land/)
- [Configuring Variables](https://wiki.hypr.land/Configuring/Variables/)
- [Keybinds](https://wiki.hypr.land/Configuring/Binds/)
- [Window Rules](https://wiki.hypr.land/Configuring/Window-Rules/)

---

**Original config preserved all your settings!**
