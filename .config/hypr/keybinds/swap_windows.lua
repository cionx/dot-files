--[[ SWAPPING/MOVING WINDOWS ON THE CURRENTLY VISIBLE WORKSPACES. ]]

local function bind_swap_windows(key, direction)
  local total_keys = Mods.swap_windows .. " + " .. key
  hl.bind(total_keys, hl.dsp.window.swap({direction = direction}))
end

for _, controller in pairs({Kbd.left_hand, Kbd.right_hand, Kbd.arrow, Mouse.wheel}) do
  for direction, key in pairs(controller) do
    bind_swap_windows(key, direction)
  end
end
