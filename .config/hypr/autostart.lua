hl.on("hyprland.start",
  function ()
    -- Authentication.
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    -- Colour shift at night time.
    hl.exec_cmd("wlsunset -l 51.5 -L 6.98 -T 6500 -t 3500")
    -- Wallpapers.
    hl.exec_cmd("hyprpaper")
    -- System bar.
    hl.exec_cmd("waybar")
  end
)
