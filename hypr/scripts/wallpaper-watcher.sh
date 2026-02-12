#!/bin/bash
# Wallpaper Watcher for Matugen
# Watches hyprpaper.conf for changes and runs matugen when wallpaper changes

HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
MATUGEN_CONF="$HOME/.config/matugen/config.toml"
CURRENT_WALLPAPER_LINK="$HOME/.config/hypr/current_wallpaper"
LOG_FILE="$HOME/.cache/matugen-watcher.log"

# Create log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Extract wallpaper path from hyprpaper.conf
get_wallpaper_path() {
    # Handle both old and new hyprpaper config formats
    local path=""
    
    # Try new format: wallpaper { path = ... }
    path=$(grep -oP 'path\s*=\s*\K[^\n]+' "$HYPRPAPER_CONF" | head -1 | xargs)
    
    # Expand ~ to $HOME
    path="${path/#\~/$HOME}"
    
    echo "$path"
}

# Get scheme type from matugen config
get_scheme_type() {
    local scheme=""
    scheme=$(grep -oP 'type\s*=\s*"\K[^"]+' "$MATUGEN_CONF" | head -1)
    
    # Default to scheme-tonal-spot if not found
    if [[ -z "$scheme" ]]; then
        scheme="scheme-tonal-spot"
    fi
    
    echo "$scheme"
}

# Run matugen with the wallpaper
run_matugen() {
    local wallpaper="$1"
    
    if [[ -z "$wallpaper" ]]; then
        log "ERROR: No wallpaper path found"
        return 1
    fi
    
    if [[ ! -f "$wallpaper" ]]; then
        log "ERROR: Wallpaper file not found: $wallpaper"
        return 1
    fi
    
    log "Running matugen with wallpaper: $wallpaper"
    
    # Get scheme type from config
    local scheme=$(get_scheme_type)
    log "Using scheme: $scheme"
    
    # Run matugen with -t flag
    matugen image "$wallpaper" -t "$scheme" 2>&1 | tee -a "$LOG_FILE"
    
    # Create/update symlink for rofi background
    ln -sf "$wallpaper" "$CURRENT_WALLPAPER_LINK"
    log "Updated current_wallpaper symlink"
    
    # Reload hyprland to apply new colors
    hyprctl reload 2>&1 | tee -a "$LOG_FILE"
    log "Reloaded Hyprland config"
    
    log "Matugen completed successfully"
}

# Initial run
log "=== Wallpaper Watcher Started ==="
CURRENT_WALLPAPER=$(get_wallpaper_path)
log "Initial wallpaper: $CURRENT_WALLPAPER"

# Run matugen on startup if colors.conf doesn't exist
if [[ ! -f "$HOME/.config/hypr/colors.conf" ]]; then
    log "colors.conf not found, running initial matugen"
    run_matugen "$CURRENT_WALLPAPER"
fi

# Watch for changes
log "Watching $HYPRPAPER_CONF for changes..."
while true; do
    inotifywait -q -e modify,close_write "$HYPRPAPER_CONF"
    
    # Small delay to let file write complete
    sleep 0.5
    
    NEW_WALLPAPER=$(get_wallpaper_path)
    
    if [[ "$NEW_WALLPAPER" != "$CURRENT_WALLPAPER" ]]; then
        log "Wallpaper changed: $NEW_WALLPAPER"
        run_matugen "$NEW_WALLPAPER"
        CURRENT_WALLPAPER="$NEW_WALLPAPER"
    else
        log "Config modified but wallpaper unchanged"
    fi
done
