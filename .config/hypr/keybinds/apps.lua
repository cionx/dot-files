--[[ APPLICATIONS. --]]

-- Keybinds that start applications are managed in a submap.
-- It can be accessed with mainMod + Space.

Bind_main_action("Space", hl.dsp.submap("programs"))

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

Bind_main_cmd("Menu", Programs.menu)
