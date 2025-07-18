require("hs.ipc")
require("keymaps")
local inspect = require("inspect")

local inputSourceMap = {
	["Alacritty"] = "ABC",
	["iTerm2"] = "ABC",
	["Zed"] = "ABC",
	["MacVim"] = "ABC",
	["CotEditor"] = "微信输入法",
	["飞书"] = "微信输入法",
	["Android Studio"] = "ABC",
	["qutebrowser"] = "ABC",
}
local inputSourceType = {
	["ABC"] = "layout",
	["Hiragana"] = "method",
	["微信输入法"] = "method",
}

local function startInputSourceSwitch()
	local appsToWatch = {}
	for k in pairs(inputSourceMap) do
		table.insert(appsToWatch, k)
	end

	hs.window.filter.new(appsToWatch):subscribe(hs.window.filter.windowFocused, function(_, name)
		local r = true
		local source = inputSourceMap[name]

		if inputSourceType[source] == "layout" then
			r = hs.keycodes.setLayout(source)
		elseif inputSourceType[source] == "method" then
			r = hs.keycodes.setMethod(source)
		else
			hs.alert.show(string.format("sourceName: %s is not layout or method", sourceName))
		end

		if not r then
			hs.alert.show(string.format("set %s to %s failure", appName, sourceName))
		end
	end)
end
startInputSourceSwitch()
