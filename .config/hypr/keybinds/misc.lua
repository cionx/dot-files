--[[ MISCELLANEOUS --]]

-- Shutting down.

Bind_main_cmd("Delete + Escape", "hyprshutdown")

-- Locking the screen.

Bind_main_cmd("KP_5", "hyprlock")

-- Close the active window.

Bind_main_action("Backspace", hl.dsp.window.close("activewindow"))

-- Rebooting waybar.

Bind_main_cmd("K", "killall waybar && sleep 2 && waybar")
