--[[
--  GENERAL RULES
--]]

-- Ignore maximizing requests from every program.
hl.window_rule({
  name = "supress-maximize-events",
  match = {
    class = ".*"
  },
  suppress_event = "maximize"
})

-- Fix some dragging issues with XWayland
hl.window_rule({
  name  = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true
})



--[[
--  FLOATING DIALOGUE BOXES
--]]

-- XDG file selection
hl.window_rule({
  name = "xdg-file-selection-float",
  match = {
    xdg_tag = "xdg-desktop-portal-gtk"
  },
  float = true
})

-- Gimp export
hl.window_rule({
  name = "gimp-export-float",
  match = {
    class = "^file-.*$",
    title = "^Export Image as .*$"
  },
  float = true
})

-- Printing
hl.window_rule({
  name = "printing-float",
  match = {
    title = "^Print — .*$"
  },
  float = true
})



--[[
--  FOCUSED DIALOGUE BOXES
--]]

-- App launcher
hl.layer_rule {
  name = "dim-wofi",
  match = {
    namespace = "wofi"
  },
  dim_around = true
}

-- Password prompt
hl.window_rule {
  name = "dim-password",
  match = {
    class = "gcr-prompter"
  },
  dim_around = true
}

-- Modal windows
hl.window_rule {
  name = "dim-modal",
  match = {
    modal = true
  },
  dim_around = true
}



--[[
--  NON—FOCUSED
--]]

-- Dolphin’s copying dialogue should not be focused upon spawning.
hl.window_rule({
  name = "nofocus-dolphin-copy",
  match = {
    title = "^Copying — Dolphin$"
  },
  no_initial_focus = true
})



--[[
--  APP SPECIFIC SETTINGS
--]]

-- Inkscape: always start as a fullscreen float.
hl.window_rule({
  name = "inkscape-fullscreen-float",
  match = {
    class = "^(org.inkscape.)?Inkscape$"
  },
  center = true,
  float = true,
  size = "(monitor_w*0.8) (monitor_h*0.8)"
})

-- XSane: always float windows.
hl.window_rule({
  name = "xsane-float",
  match = {
    class = "^Xsane$"
  },
  float = true
})
