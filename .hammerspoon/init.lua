-- hs.hotkey.bind({"shift", "alt"}, "W", function()
--   hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
-- end)

---------------- Appliction -----------------
hs.hotkey.bind({"alt"}, "1", function ()
  hs.application.launchOrFocus("Alacritty")
end)

hs.hotkey.bind({"alt"}, "2", function ()
  hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({"alt"}, "3", function ()
  hs.application.launchOrFocus("Zed")
end)

hs.hotkey.bind({"alt"}, "4", function ()
  hs.application.launchOrFocus("Lark")
end)

hs.hotkey.bind({"alt"}, "0", function ()
  hs.application.launchOrFocus("Telegram")
end)

hs.hotkey.bind({"alt"}, "9", function ()
  hs.application.launchOrFocus("Proxyman")
end)

hs.hotkey.bind({"alt"}, "8", function ()
  hs.application.launchOrFocus("Figma")
end)

hs.hotkey.bind({"alt", "shift"}, "C", function ()
  hs.application.launchOrFocus("CotEditor")
end)

hs.hotkey.bind({"alt", "shift"}, "G", function ()
  hs.application.launchOrFocus("Google Chrome Canary")
end)

hs.hotkey.bind({"alt", "shift"}, "R", function ()
  hs.reload()
end)
hs.alert.show("Config Reload")

hs.hotkey.bind({"alt", "shift"}, "I", function ()
  hs.application.launchOrFocus("Settings")
end)

hs.hotkey.bind({"ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

inspect = require 'lib.inspect'
