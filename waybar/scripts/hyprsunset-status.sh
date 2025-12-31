#!/bin/bash

# Hyprsunset'in çalışıp çalışmadığını kontrol et
if pidof hyprsunset > /dev/null 2>&1; then
    echo '{"text": "☪︎", "class": "active", "tooltip": "Night Light: Açık"}'
else
    echo '{"text": "☀️", "class": "inactive", "tooltip": "Night Light: Kapalı"}'
fi
