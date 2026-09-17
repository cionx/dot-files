--[[ OFTEN USED PROGRAMS --]]

Programs = {
  terminal    = "kitty",
  editor      = "nvim",
  menu        = "wofi",
  fileManager = "dolphin",
  webBrowser  = "firefox",
}



--[[ SCREENSHOT COMMANDS --]]

local screenshotOptions = table.concat({
  -- File name format: screenshot_YYYYMMDD_HHMMSS.png
  -- This also ensures screenshots are saved as PNGs.
  [[--filename "$(date +'screenshot_%Y%m%d_%H%M%S').png"]],
  -- Screenshots are saved into: ~/screenshots
  "--output-folder ~/screenshots",
  -- Before saving, the PNG image is piped through optipng for further lossless compression.
  "-- optipng",
  },
  " "
)

Screenshot = {
  region  = "hyprshot --mode region " .. screenshotOptions,
  window  = "hyprshot --mode window " .. screenshotOptions,
  monitor = "hyprshot --mode output --mode active " .. screenshotOptions,
}
