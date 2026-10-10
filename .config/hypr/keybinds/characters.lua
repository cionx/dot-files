--[[ DRAWING CHARACTERS --]]

Bind_main_action("B", hl.dsp.submap("box_drawing_full"))

-- Box drawing characters (https://en.wikipedia.org/wiki/Box-drawing_characters).

local box_chars = {
  full = {
    top_left     = "┌",
    top_right    = "┐",
    bottom_left  = "└",
    bottom_right = "┘",
    vertical     = "│",
    horizontal   = "─",
  },
  half = {
    top    = "╵",
    bottom = "╷",
    left   = "╴",
    right  = "╶",
  },
}

local box_keys = {
  full = {
    [1] = box_chars.full.bottom_left,
    [2] = box_chars.full.horizontal,
    [3] = box_chars.full.bottom_right,
    [4] = box_chars.full.vertical,
    [6] = box_chars.full.vertical,
    [7] = box_chars.full.top_left,
    [8] = box_chars.full.horizontal,
    [9] = box_chars.full.top_right,
  },
  half = {
    [2] = box_chars.half.top,
    [4] = box_chars.half.right,
    [6] = box_chars.half.left,
    [8] = box_chars.half.bottom,
  }
}

hl.define_submap("box_drawing_full", function()
  for num, char in pairs(box_keys.full) do
    local key = "KP_" .. tostring(num)
    local cmd = string.format([[wtype '%s']], char)
    hl.bind(key, hl.dsp.exec_cmd(cmd))
  end
  -- Switch to half characters.
  hl.bind("KP_Subtract", hl.dsp.submap("box_drawing_half"))
  -- Manually exit the submap with keypad 0.
  hl.bind("KP_0", hl.dsp.submap("reset"))
end)

hl.define_submap("box_drawing_half", function()
  for num, char in pairs(box_keys.half) do
    local key = "KP_" .. tostring(num)
    local cmd = string.format([[wtype '%s']], char)
    hl.bind(key, hl.dsp.exec_cmd(cmd))
  end
  -- Switch to full characters.
  hl.bind("KP_Add", hl.dsp.submap("box_drawing_full"))
  -- Manually exit the submap with keypad 0.
  hl.bind("KP_0", hl.dsp.submap("reset"))
end)
