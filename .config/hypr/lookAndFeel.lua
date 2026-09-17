hl.config({
  general = {

    gaps_in  = 0, -- Gaps between different windows.
    gaps_out = 0, -- Gaps between windows and screen edges.

    border_size = 2,

    col = {
      active_border = {colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45},
      inactive_border = "rgba(595959aa)",
    },
  },
})



hl.config({
  decoration = {
    rounding_power = 2, -- circular corners
    rounding = 5,       -- rounded corner radius
  },
})



hl.config({
  animations = {
    enabled = false,
  }
})



hl.config({
  cursor = {
    no_warps = true,
    default_monitor = "DP-2",
  }
})



hl.config({
  render = {
    direct_scanout = 2,
  }
})



hl.config({
  misc = {
    disable_hyprland_logo = true,
    force_default_wallpaper = 0,
  }
})
