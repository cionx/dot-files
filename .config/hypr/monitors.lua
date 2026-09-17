-- Left monitor (horizontal).
hl.monitor({
  output   = "DP-1",
  mode     = "1920x1200@60",
  position = "0x0",
  scale    = 1
})

-- Center monitor (horizontal).
hl.monitor({
  output   = "DP-2",
  mode     = "1920x1200@60",
  position = "1920x0",
  scale    = 1
})

-- Right monitor (vertical).
hl.monitor({
  output    = "DP-3",
  mode      = "1920x1080@60",
  position  = "3840x-420",
  scale     = 1,
  transform = 1 -- Rotate counter-clockwise by 90 degrees.
})



-- 11 persistent workspaces:
-- | 1 on the left monitor.
-- | 5 on the center.
-- | 5 on the right.

local function declare_persistent_workspace(id, monitor)
  hl.workspace_rule({workspace = tostring(id), monitor = monitor, persistent = true})
end

declare_persistent_workspace(1, "DP-1")

for i = 2, 6 do
  declare_persistent_workspace(i, "DP-2")
end

for i = 7, 11 do
  declare_persistent_workspace(i, "DP-3")
end

-- Set the default workspace as the first workspace on the center monitor.

hl.workspace_rule({workspace = "2", default = true})
