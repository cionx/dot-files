--[[ SCREENSHOTS --]]

-- Screenshots can be taken with:
--   mainMod + (Print, Scroll_Lock or Pause)
-- More specifically:
-- | Print       screenshots a rectangular selection of the screens.
-- | Scroll_Lock screenshots the current window.
-- | Pause       screenshots the current monitor.

Bind_main_cmd("Print",       Screenshot.region)
Bind_main_cmd("Scroll_Lock", Screenshot.window)
Bind_main_cmd("Pause",       Screenshot.monitor)
