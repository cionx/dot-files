--[[
  MOUSE CODES
  as determined with xev/wev

  272: left click
  273: right click
  274: middle click
  275: backwards
  276: forwards
  mouse_up:    scrolling up
  mouse_down:  scrolling down
  mouse_left:  tilt mouse wheel to the left
  mouse_right: tilt mouse wheel to the right
--]]

local mouse = {
  button = {
    left      = "mouse:272",
    right     = "mouse:273",
    middle    = "mouse:274",
    backwards = "mouse:275",
    forwards  = "mouse:276",
  },
  wheel = {
    up    = "mouse_up",
    down  = "mouse_down",
    left  = "mouse_left",
    right = "mouse_right",
  },
}

local kbd = {
  -- WASD = OAEI in Koy
  left_hand = {
    up    = "O",
    left  = "A",
    down  = "E",
    right = "I"
  },
  -- right hand WASD = IJKL = CTRN in Koy
  right_hand = {
    up    = "C",
    left  = "T",
    down  = "R",
    right = "N"
  },
  -- arrow keys
  arrow = {
    up    = "up",
    left  = "left",
    down  = "down",
    right = "right"
  },
}



--[[ MODIFIERS ]]

local mods = {
  main                  = "SUPER",
  swap_windows          = "SUPER + SHIFT",
  switch_workspace      = "SUPER + ALT",
  move_window_workspace = "SUPER + ALT + SHIFT",
}

local function bind_main_action(key, action, flags) -- flags are optional.
  flags = flags or {} -- No flags by default.
  local total_keys = mods.main .. " + " .. key
  hl.bind(total_keys, action, flags)
end

local function bind_main_cmd(key, command, flags) -- flags are optional.
  bind_main_action(key, hl.dsp.exec_cmd(command), flags)
end



--[[ SHUTING DOWN & LOCKING SCREEN --]]

bind_main_cmd("Escape", "hyprshutdown")

bind_main_cmd("KP_5", "hyprlock")



--[[ TEMPORARY --]]

bind_main_cmd("K", "killall waybar && sleep 2 && waybar")



--[[ APPLICATIONS --]]

-- Keybinds that start applications are managed in a submap.
-- It can be accessed with mainMod + Space.

bind_main_action("Space", hl.dsp.submap("programs"))

hl.define_submap("programs", "reset", function()
  -- The available key bindings.
  hl.bind("F", hl.dsp.exec_cmd(Programs.fileManager))
  hl.bind("R", hl.dsp.exec_cmd(Programs.menu))
  hl.bind("T", hl.dsp.exec_cmd(Programs.terminal))
  hl.bind("E", hl.dsp.exec_cmd(Programs.terminal .. " -e " .. Programs.editor))
  hl.bind("B", hl.dsp.exec_cmd(Programs.webBrowser))
  -- Manually exit the submap with Escape.
  hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- For simplicity, the menu can also be accessed more directly.

bind_main_cmd("Menu", Programs.menu)

-- Screenshots can be taken with:
--   mainMod + (Print, Scroll_Lock or Pause)
-- More specifically:
-- | Print       screenshots a rectangular selection of the screens.
-- | Scroll_Lock screenshots the current window.
-- | Pause       screenshots the current monitor.

bind_main_cmd("Print",       Screenshot.region)
bind_main_cmd("Scroll_Lock", Screenshot.window)
bind_main_cmd("Pause",       Screenshot.monitor)



--[[ VOLUME CONTROL --]]

-- The volume can be controlled with:
--   mainMod + (Delete, End or Next)
-- More specifically:
-- | Delete decreases the audio by 5%.
-- | End    toggles mute.
-- | Next   increases the audio by 5%.
-- 
local volume_flags = {locked = true, repeating = true}
bind_main_cmd("Delete", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",    volume_flags)
bind_main_cmd("End",    "wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle", volume_flags)
bind_main_cmd("Next",   "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+",    volume_flags)



--[[ LAYOUT MANIPULATION --]]

-- Dwindle layout:
-- | S swaps the two windows in the current split.
-- | J toggles between horizontal and vertical split.

bind_main_action("S", hl.dsp.layout("swapsplit"))
bind_main_action("J", hl.dsp.layout("togglesplit"))

-- Breaking out of the layout:
-- | F toggles fullscreen.
-- | V toggles floating.
-- | P toggles pseudo.

bind_main_action("F", hl.dsp.window.fullscreen("activewindow", "toggle"))
bind_main_action("V", hl.dsp.window.float("activewindow", "toggle"))
bind_main_action("P", hl.dsp.window.pseudo("activewindow"))



--[[ WINDOW STATUS MANIPULATION ]]

-- Close the active window

bind_main_action("Backspace", hl.dsp.window.close("activewindow"))

-- Drag window positions with mainMod + LMB.

bind_main_action(mouse.button.left,  hl.dsp.window.drag(),   {mouse = true})

-- Resize floating/pseudo windows with mainMod + RMB.

bind_main_action(mouse.button.right, hl.dsp.window.resize(), {mouse = true})



--[[ MOVING FOCUS BETWEEN VISIBLE WINDOWS --]]

-- Move focus between windows ...
local function bind_move_focus(key, direction)
  bind_main_action(key,  hl.dsp.focus({direction = direction}))
end
for _, controller in pairs({kbd.left_hand, kbd.right_hand, kbd.arrow, mouse.wheel}) do
  for direction, key in pairs(controller) do
    bind_move_focus(key, direction)
  end
end



--[[ SWAPPING WINDOWS ON THE VISIBLE WORKSPACES ]]

local function bind_swap_windows(key, direction)
  local total_keys = mods.swap_windows .. " + " .. key
  hl.bind(total_keys, hl.dsp.window.swap({direction = direction}))
end
for _, controller in pairs({kbd.left_hand, kbd.right_hand, kbd.arrow, mouse.wheel}) do
  for direction, key in pairs(controller) do
    bind_swap_windows(key, direction)
  end
end



--[[ SWITCH BETWEEN WORKSPACES --]]

local function bind_switch_workspace(key, workspace)
  local total_keys = mods.switch_workspace .. " + " .. key
  hl.bind(total_keys, hl.dsp.focus({workspace = workspace}))
end

local workspaces = {
  previous = "m-1",
  next     = "m+1",
}

for _, controller in pairs({kbd.left_hand, kbd.right_hand, kbd.arrow, mouse.wheel}) do
  bind_switch_workspace(controller.left,  workspaces.previous)
  bind_switch_workspace(controller.right, workspaces.next)
end
bind_switch_workspace(mouse.wheel.down, workspaces.previous)
bind_switch_workspace(mouse.wheel.up,   workspaces.next)
bind_switch_workspace(mouse.button.backwards, workspaces.previous)
bind_switch_workspace(mouse.button.forwards,  workspaces.next)

-- Switch to a specific workspace.
for i = 1, 9 do
  bind_switch_workspace(tostring(i), tostring(i + 1))
end
bind_switch_workspace("0", "11")



--[[ MOVE WINDOWS BETWEEN WORKSPACES --]]

local function bind_move_window_workspace(key, workspace)
  local total_keys = mods.move_window_workspace .. " + " .. key
  hl.bind(total_keys, hl.dsp.window.move({workspace = workspace}))
end

-- Move a window to the next/previous workspace with ...
-- keyboard (left).
bind_move_window_workspace(kbd.arrow.left,  workspaces.previous)
bind_move_window_workspace(kbd.arrow.right, workspaces.next)
-- keyboard (right).
bind_move_window_workspace(kbd.right_hand.left,  workspaces.previous)
bind_move_window_workspace(kbd.right_hand.right, workspaces.next)
-- mouse wheel (vertical).
bind_move_window_workspace(mouse.wheel.down, workspaces.previous)
bind_move_window_workspace(mouse.wheel.up,   workspaces.next)
-- mouse wheel (horizontal).
bind_move_window_workspace(mouse.wheel.left,  workspaces.previous)
bind_move_window_workspace(mouse.wheel.right, workspaces.next)
-- mouse (side buttons).
bind_move_window_workspace(mouse.button.backwards, workspaces.previous)
bind_move_window_workspace(mouse.button.forwards,  workspaces.next)

-- Switch to a specific workspace.
for i = 1, 9 do
  bind_move_window_workspace(tostring(i), tostring(i + 1))
end
bind_move_window_workspace("0", "11")
