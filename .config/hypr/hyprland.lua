-- Hardware
require("monitors")
require("input")

-- Style
require("layouts")
require("windowrules")
require("lookAndFeel")

-- Programs
require("autostart")
require("programs")

-- Usage
-- We need to load the “global” keybind file first, so that its contents are available to all later files.
-- Normally, this should be done via “require” in the other files, but this doesn’t work for some reason.
require("keybinds.global")
require("./keybinds/*")

-- Others
require("envariables")
