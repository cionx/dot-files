--[[ "GLOBAL" KEYBINDING STUFF. --]]

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

Mouse = {
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

Kbd = {
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

Mods = {
  main                  = "SUPER",
  swap_windows          = "SUPER + ALT",
  switch_workspace      = "SUPER + CTRL",
  move_window_workspace = "SUPER + CTRL + ALT",
}

function Bind_main_action(key, action, flags) -- flags are optional.
  flags = flags or {} -- No flags by default.
  local total_keys = Mods.main .. " + " .. key
  hl.bind(total_keys, action, flags)
end

function Bind_main_cmd(key, command, flags) -- flags are optional.
  Bind_main_action(key, hl.dsp.exec_cmd(command), flags)
end



--[[ WORKSPACES ]]

Workspaces = {
  next     = "m+1",
  previous = "m-1",
}
