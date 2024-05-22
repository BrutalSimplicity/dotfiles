-- hs ./canvas.lua
---@diagnostic disable: lowercase-global
screen = require("hs.screen")
alert = require("hs.alert")
i = require("hs.inspect")
c = require("hs.canvas")
t = require("hs.timer")

m = screen.mainScreen()
f = m:frame()
print(i(f))

a = c.new({
	x = f.x + 100,
	y = f.y + 100,
	h = 500,
	w = 500,
})
	:appendElements({
		type = "rectangle",
		action = "strokeAndFill",
	})
	:show()
t.doAfter(10, function()
	a:delete()
end)
