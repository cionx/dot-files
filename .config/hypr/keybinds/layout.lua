--[[ LAYOUT-SPECIFIC KEYBINDINGS. ]]

-- Dwindle layout:
-- | S swaps the two windows in the current split.
-- | J toggles between horizontal and vertical split.

Bind_main_action("S", hl.dsp.layout("swapsplit"))
Bind_main_action("J", hl.dsp.layout("togglesplit"))

-- Non-Dwindle windows:
-- | F toggles fullscreen.
-- | V toggles floating.
-- | P toggles pseudo.

Bind_main_action("F", hl.dsp.window.fullscreen("activewindow", "toggle"))
Bind_main_action("V", hl.dsp.window.float("activewindow", "toggle"))
Bind_main_action("P", hl.dsp.window.pseudo("activewindow"))

-- Drag window to a position with mainMod + LMB.

Bind_main_action(Mouse.button.left,  hl.dsp.window.drag(),   {mouse = true})

-- Resize a floating/pseudo window with mainMod + RMB.

Bind_main_action(Mouse.button.right, hl.dsp.window.resize(), {mouse = true})
