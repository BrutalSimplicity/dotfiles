#!/usr/bin/env -S hs
-- hs ./canvas.lua
---@diagnostic disable: lowercase-global
screen = require("hs.screen")
alert = require("hs.alert")
i = require("hs.inspect")

m = screen.mainScreen()
f = m:frame()
hs.printf(i(f))

mod = { "cmd", "alt", "ctrl" }
local function bind(key, canvas)
	hs.hotkey.bind(mod, key, function()
		canvas:show()
		local hk
		hk = hs.hotkey.bind({}, "escape", function()
			canvas:delete()
			hk:delete()
			hk = nil
		end)
	end)
end

local syscolors = hs.drawing.color.colorsFor("System")
local colors = {
	bg = {
		red = 0.15,
		blue = 0.15,
		green = 0.15,
		alpha = 0.80,
	},
	font = hs.drawing.color.hammerspoon.white,
	view = syscolors.controlBackgroundColor,
}
hs.printf(i(colors))
colors.bg.alpha = 0.75
colors.view.alpha = 0.75
local font = hs.styledtext.convertFont({
	name = "MesloLGS Nerd Font Mono",
	size = 18,
}, false)
local text = hs.styledtext.new(
	[[
<H-1> → MelsoLGS Nerd Font Mono
<H-1> → MelsoLGS Nerd Font Mono
<H-1> → MelsoLGS Nerd Font Mono
<H-1> → MelsoLGS Nerd Font Mono
<H-1> → Really, really, long line, with more text than will fit on a single line
]],
	{
		font = font,
		color = colors.font,
		paragraphStyle = {
			lineBreak = "truncateTail",
			lineSpacing = 1.5,
		},
	}
)
print(i(text:asTable()))
local textsize = hs.drawing.getTextDrawingSize(text)
print(i(textsize))
local frame = {
	h = f.h / 5,
	w = f.w * 0.8,
	margin = { 0, 0, 20, 0 },
}
bind(
	"a",
	hs.canvas
		.new({
			x = (f.x + f.w / 2) - frame.w / 2,
			y = f.h - frame.h - frame.margin[3],
			h = frame.h,
			w = frame.w,
		})
		:appendElements({
			type = "rectangle",
			action = "fill",
			roundedRectRadii = { xRadius = 10, yRadius = 10 },
			fillColor = colors.bg,
		})
		:appendElements({
			type = "text",
			text = text,
			frame = {
				x = 20,
				y = 20,
				w = 480,
				h = frame.h,
			},
		})
)

bind(
	"b",
	hs.canvas
		.new({
			x = (f.x + f.w / 2) - 250,
			y = f.h - 500 - 20,
			h = 500,
			w = 500,
		})
		:appendElements({
			type = "text",
			text = "Text",
		})
)
