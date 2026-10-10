--[[ MOVE WINDOWS BETWEEN WORKSPACES. --]]

local function bind_move_window_workspace(key, workspace)
  local total_keys = Mods.move_window_workspace .. " + " .. key
  hl.bind(total_keys, hl.dsp.window.move({workspace = workspace}))
end

-- Move a window to the next/previous workspace with ...
-- keyboard (left).
bind_move_window_workspace(Kbd.arrow.left,  Workspaces.previous)
bind_move_window_workspace(Kbd.arrow.right, Workspaces.next)
-- keyboard (right).
bind_move_window_workspace(Kbd.right_hand.left,  Workspaces.previous)
bind_move_window_workspace(Kbd.right_hand.right, Workspaces.next)
-- mouse wheel (vertical).
bind_move_window_workspace(Mouse.wheel.down, Workspaces.previous)
bind_move_window_workspace(Mouse.wheel.up,   Workspaces.next)
-- mouse wheel (horizontal).
bind_move_window_workspace(Mouse.wheel.left,  Workspaces.previous)
bind_move_window_workspace(Mouse.wheel.right, Workspaces.next)
-- mouse (side buttons).
bind_move_window_workspace(Mouse.button.backwards, Workspaces.previous)
bind_move_window_workspace(Mouse.button.forwards,  Workspaces.next)

-- Switch to a specific workspace.
for i = 1, 9 do
  bind_move_window_workspace(tostring(i), tostring(i + 1))
end
bind_move_window_workspace("0", "11")
