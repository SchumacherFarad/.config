#!/bin/bash

# Hyprsunset'in çalışıp çalışmadığını kontrol et
if pgrep -x "hyprsunset" > /dev/null; then
    # Çalışıyorsa kapat
    pkill hyprsunset
else
    # Çalışmıyorsa başlat (4500K sıcaklık ile, istediğiniz değeri değiştirebilirsiniz)
    hyprsunset -t 4500 &
fi