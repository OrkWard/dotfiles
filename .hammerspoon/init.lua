-- hs.hotkey.bind({"shift", "alt"}, "W", function()
--   hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
-- end)

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

