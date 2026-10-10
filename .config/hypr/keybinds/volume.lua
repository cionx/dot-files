--[[ AUDIO VOLUME CONTROL. --]]

-- The audio volume can be controlled with:
--   mainMod + (Delete, End or Next)
-- More specifically:
-- | Delete decreases the audio by 5%.
-- | End    toggles mute.
-- | Next   increases the audio by 5%.

local volume_flags = {locked = true, repeating = true}
Bind_main_cmd("Delete", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",    volume_flags)
Bind_main_cmd("End",    "wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle", volume_flags)
Bind_main_cmd("Next",   "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+",    volume_flags)
