#!/bin/bash

# Check if dunst notifications are paused (DND mode)
if dunstctl is-paused | grep -q "true"; then
    echo '{"text": "⊘", "class": "active", "tooltip": "Do Not Disturb: On"}'
else
    echo '{"text": "🔔", "class": "inactive", "tooltip": "Do Not Disturb: Off"}'
fi
