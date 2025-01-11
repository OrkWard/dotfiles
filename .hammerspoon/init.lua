hs.hotkey.bind({"shift", "alt"}, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)
