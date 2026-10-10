--[[ MOVE FOCUS BETWEEN WINDOWS. --]]

local function bind_move_focus(key, direction)
  Bind_main_action(key, hl.dsp.focus({direction = direction}))
end

for _, controller in pairs({Kbd.left_hand, Kbd.right_hand, Kbd.arrow, Mouse.wheel}) do
  for direction, key in pairs(controller) do
    bind_move_focus(key, direction)
  end
end
