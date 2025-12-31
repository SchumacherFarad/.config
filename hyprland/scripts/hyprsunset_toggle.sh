#!/binbin/bash

# Varsayılan değerler
TEMPERATURE_ON=5000
TEMPERATURE_OFF=6500

# Hyprsunset'i açıp kapatan ana fonksiyon
toggle() {
    # Hyprsunset'in mevcut sıcaklığını al
    CURRENT_TEMP=$(hyprctl -j hyprsunset | jq -r .temperature)

    # ÖNEMLİ: jq'dan 'null' gelip gelmediğini veya boş olup olmadığını kontrol et
    # Bu, hyprsunset çalışmıyorken betiğin çökmesini engeller.
    if [[ -z "$CURRENT_TEMP" || "$CURRENT_TEMP" == "null" ]]; then
        # hyprsunset çalışmıyor olabilir, başlatmayı dene (Gece modu)
        hyprctl hyprsunset temperature $TEMPERATURE_ON
        
    # DÜZELTME: Sayısal karşılaştırma için (( ... )) kullanıldı.
    elif (( CURRENT_TEMP <= 6000 )); then
        # Şu an aktif (örneğin 5000), kapat (normal moda geç)
        hyprctl hyprsunset temperature $TEMPERATURE_OFF
    else
        # Şu an kapalı/normal (örneğin 6500), aç (gece moduna geç)
        hyprctl hyprsunset temperature $TEMPERATURE_ON
    fi
}

# Waybar için durumu JSON formatında döndüren fonksiyon
get_status() {
    # Hyprsunset'in mevcut sıcaklığını al
    CURRENT_TEMP=$(hyprctl -j hyprsunset | jq -r .temperature)

    # ÖNEMLİ: 'null' veya boş kontrolü
    if [[ -z "$CURRENT_TEMP" || "$CURRENT_TEMP" == "null" ]]; then
        ICON="⚠️"
        CLASS="sunset-error"
        TEXT="Hyprsunset durumu okunamadı."

    # DÜZELTME: Sayısal karşılaştırma için (( ... )) kullanıldı.
    elif (( CURRENT_TEMP <= 6000 )); then
        # 6000'den düşükse veya eşitse Gece Modu AÇIK varsayılır.
        ICON="🌙" # Gece Modu AÇIK
        CLASS="sunset-on"
        TEXT="Gece Modu AÇIK ($CURRENT_TEMP)"
    else
        # 6000'den yüksekse veya eşitse Normal Mod/KAPALI varsayılır.
        ICON="🌞" # Normal Mod / Gece Modu KAPALI
        CLASS="sunset-off"
        TEXT="Gece Modu KAPALI ($CURRENT_TEMP)"
    fi

    # Waybar'a JSON çıktısı
    echo "{\"text\": \"$ICON\", \"tooltip\": \"$TEXT\", \"class\": \"$CLASS\"}"
}

# Betiğin hangi fonksiyonu çalıştıracağını belirleme
case "$1" in
    toggle)
        toggle
        ;;
    status)
        get_status
        ;;
    *)
        # Varsayılan olarak durumu döndür
        get_status
        ;;
esac