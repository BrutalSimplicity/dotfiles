local Keybinder = require("keybinder")
describe("keybinder", function()
	it("should parse simple modifiers", function()
		local keys = Keybinder.parse_keys("<C-a>")
	end)
end)