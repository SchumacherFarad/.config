local mainMod = "SUPER"

hl.bind(mainMod .. " + T",            hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + E",    hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE",        hl.dsp.exec_cmd("rofi -show drun"))

hl.bind(mainMod .. " + W",              hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + W",      hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper-picker.sh"))
hl.bind(mainMod .. " + M",              hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + V",              hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",              hl.dsp.window.pin())
hl.bind(mainMod .. " + J",              hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F",              hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + SHIFT + left",   hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right",  hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up",     hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down",   hl.dsp.window.move({ direction = "d" }))

hl.bind(mainMod .. " + L",              hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + left",   hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right",  hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",     hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",   hl.dsp.focus({ direction = "d" }))

for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S",            hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S",    hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down",   hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",     hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272",    hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273",    hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 10%+"), { repeating = true })

hl.bind("XF86KbdBrightnessUp",   hl.dsp.exec_cmd("swayosd-client --brightness +10"), { repeating = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness -10"), { repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next && notify-send \"Sonraki Parça\" \"$(playerctl metadata title) - $(playerctl metadata artist)\" -i media-skip-forward"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous && notify-send \"Önceki Parça\" \"$(playerctl metadata title) - $(playerctl metadata artist)\" -i media-skip-backward"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause && notify-send \"Medya\" \"Oynat/Duraklat\" -i media-playback-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause && notify-send \"Medya\" \"Oynat/Duraklat\" -i media-playback-start"), { locked = true })

hl.bind("Print", hl.dsp.exec_cmd("~/.local/bin/hypr-screenshot"))
