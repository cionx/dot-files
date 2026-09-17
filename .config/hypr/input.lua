-- KEYBOARD.
hl.config({
  input = {
    -- The layout.
    kb_layout  = "de",
    kb_variant = "koy",
    --[[
    -- When a key is held down, then
    -- * repeat_rate controls how many key-presses per second are registered;
    -- * repeat_delay controls how long it takes for the repeated key-presses to kick in.
    -- If one wants to move through a (text) file by holding direction keys down, then
    -- * repeat_rate controls the speed and
    -- * repeat_delay how long it takes to start moving.
    --]]
    repeat_rate =  25,
    repeat_delay = 400
  }
})



-- DRAWING TABLET.
hl.config({
  input = {
    tablet = {
      output = "DP-2"
    }
  }
})
