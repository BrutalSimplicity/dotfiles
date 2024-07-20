#!/usr/bin/env hs
Snyper = { "cmd", "alt", "ctrl" }
hs.hotkey.bind(Snyper, "1", function()
	local choices = {
		{
			["text"] = "First Choice",
			["subText"] = "This is the subtext of the first choice",
			["uuid"] = "0001",
			image = hs.image.imageFromName("NSStatusAvailable"),
		},
		{
			["text"] = "Second Option",
			["subText"] = "I wonder what I should type here?",
			["uuid"] = "Bbbb",
		},
		{
			["text"] = hs.styledtext.new(
				"Third Possibility",
				{ font = { size = 18 }, color = hs.drawing.color.definedCollections.hammerspoon.green }
			),
			["subText"] = "What a lot of choosing there is going on here!",
			["uuid"] = "III3",
		},
	}

	hs.chooser
		.new(function(item)
			if item == nil then
				hs.printf("Chooser closed")
			else
				hs.printf("Item selected: \n" .. hs.inspect(item))
			end
		end)
		:choices(choices)
		:show()
end)

hs.hotkey.bind(Snyper, "2", function()
	local choices = {}
	for _, a in ipairs(hs.application.runningApplications()) do
		choices[#choices + 1] = {
			text = a:name(),
			subText = a:title(),
			image = a:bundleID() ~= nil and hs.image.imageFromAppBundle(a:bundleID()) or nil,
			valid = a:kind() == 0,
			pid = a:pid(),
		}
	end
	hs.chooser
		.new(function(item)
			if item == nil then
				hs.printf("Chooser closed")
			else
				hs.printf("Item selected: \n" .. hs.inspect(item))
			end
		end)
		:choices(choices)
		:show()
end)
