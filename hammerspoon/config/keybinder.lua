local M = {}

M.keys = {
	ctrl = {
		name = "ctrl",
		short = "C",
		icon = "󰘴",
		hotkey = "ctrl",
		modifier = true,
	},
	meta = {
		name = "meta",
		short = "M",
		icon = "󰘵",
		hotkey = "alt",
		modifier = true,
	},
	shift = {
		name = "shift",
		short = "S",
		icon = "󰘶",
		hotkey = "shift",
		modifier = true,
	},
	super = {
		name = "super",
		short = "D",
		icon = "󰘳",
		hotkey = "cmd",
		modifier = true,
	},
	hyper = {
		name = "hyper",
		short = "H",
		icon = "✧",
		hotkey = { "cmd", "ctrl", "alt", "shift" },
		alias = true,
	},
	enter = {
		name = "enter",
		short = "CR",
		icon = "󰌑",
		hotkey = "enter",
	},
	space = {
		name = "space",
		short = "SPC",
		icon = "󱁐",
		hotkey = "space",
	},
	escape = {
		name = "escape",
		short = "ESC",
		icon = "󱊷",
		hotkey = "escape",
	},
	backspace = {
		name = "backspace",
		short = "BSP",
		icon = "󰌍",
		hotkey = "backspace",
	},
}
local function defaultkey(sym)
	return {
		name = sym,
		short = sym,
		hotkey = sym,
	}
end
local keysyms = {
	c = M.keys.ctrl,
	ctrl = M.keys.ctrl,
	m = M.keys.meta,
	meta = M.keys.meta,
	o = M.keys.meta,
	a = M.keys.meta,
	alt = M.keys.meta,
	s = M.keys.shift,
	shift = M.keys.shift,
	h = M.keys.hyper,
	hyper = M.keys.hyper,
	cr = M.keys.enter,
	enter = M.keys.enter,
	["return"] = M.keys.enter,
	esc = M.keys.escape,
	escape = M.keys.escape,
	bsp = M.keys.backspace,
	lt = "<",
	gt = ">",
	f1 = "f1",
	f2 = "f2",
	f3 = "f3",
	f4 = "f4",
	f5 = "f5",
	f6 = "f6",
	f7 = "f7",
	f8 = "f8",
	f9 = "f9",
	f10 = "f10",
	f11 = "f11",
	f12 = "f12",
}
-- Parse a vim-style string of keys into appropriate mods and keys for hs.hotkey.bind
---@param keys string
function M.parse_keys(keys)
	local result = {}
	keys = keys:gsub("%s", "")
	local match = keys:match("^<.*>")
	if match then
		local mods = {}
		for m in match:gsub("(%w*)-") do
			mods[#mods + 1] = m:sub(1, #m - 1)
		end
	end
	local _keys = {}
	for i = #match, #keys do
		local k = keys:byte(i)
	end
end
return M
