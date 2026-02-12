#!/bin/bash
# Wallpaper Picker - Select wallpaper with rofi and apply with hyprpaper
# Colors will automatically update via matugen-watcher service

WALLPAPER_DIR="$HOME/Resimler"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

# Check if rofi is installed
if ! command -v rofi &> /dev/null; then
    notify-send "Hata" "rofi kurulu değil!"
    exit 1
fi

# Check if hyprpaper is running
if ! pgrep -x "hyprpaper" > /dev/null; then
    notify-send "Uyarı" "hyprpaper çalışmıyor, başlatılıyor..."
    hyprpaper &
    sleep 1
fi

# Get list of image files
images=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) 2>/dev/null | sort)

if [[ -z "$images" ]]; then
    notify-send "Hata" "$WALLPAPER_DIR dizininde resim bulunamadı!"
    exit 1
fi

# Show rofi menu with image names
selected=$(echo "$images" | while read -r img; do
    basename "$img"
done | rofi -dmenu -i -p "Duvar Kağıdı Seç" -theme-str 'window {width: 400px;}')

# Exit if nothing selected
if [[ -z "$selected" ]]; then
    exit 0
fi

# Get full path of selected image
selected_path=$(echo "$images" | grep -F "/$selected" | head -1)

if [[ -z "$selected_path" || ! -f "$selected_path" ]]; then
    notify-send "Hata" "Seçilen dosya bulunamadı!"
    exit 1
fi

# Update hyprpaper.conf
cat > "$HYPRPAPER_CONF" << EOF
splash = false
wallpaper {
    monitor = 
    path = $selected_path
    fit_mode = cover
}
EOF

# Reload hyprpaper
hyprctl hyprpaper unload all 2>/dev/null
hyprctl hyprpaper preload "$selected_path" 2>/dev/null
hyprctl hyprpaper wallpaper ",$selected_path" 2>/dev/null

notify-send "Duvar Kağıdı Değiştirildi" "$(basename "$selected_path")"

# Note: matugen-watcher will automatically detect the change and update colors
