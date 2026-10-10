-- [[ SWITCH BETWEEN WORKSPACES. --]]

local function bind_switch_workspace(key, workspace)
  local total_keys = Mods.switch_workspace .. " + " .. key
  hl.bind(total_keys, hl.dsp.focus({workspace = workspace}))
end

for _, controller in pairs({Kbd.left_hand, Kbd.right_hand, Kbd.arrow, Mouse.wheel}) do
  bind_switch_workspace(controller.left,  Workspaces.previous)
  bind_switch_workspace(controller.right, Workspaces.next)
end
bind_switch_workspace(Mouse.wheel.down, Workspaces.previous)
bind_switch_workspace(Mouse.wheel.up,   Workspaces.next)
bind_switch_workspace(Mouse.button.backwards, Workspaces.previous)
bind_switch_workspace(Mouse.button.forwards,  Workspaces.next)

-- Switch to a specific workspace.
for i = 1, 9 do
  bind_switch_workspace(tostring(i), tostring(i + 1))
end
bind_switch_workspace("0", "11")
