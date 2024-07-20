#!/usr/bin/env hs
YabaiPath = "/opt/homebrew/bin/yabai"
Logger = hs.logger.new("windows", "debug")
local log = function(k, o)
	Logger.d(string.format("%s: %s", k, hs.inspect(o)))
end
local function send(args, cb)
	assert(args ~= nil, "args is nil")
	table.insert(args, 1, "-m")
	log("args", args)
	hs.task
		.new(YabaiPath, function(code, out, err)
			if code == 0 then
				cb(hs.json.decode(out))
			else
				log("yabai cmd failed", {
					cmd = YabaiPath,
					args = args,
					code = code,
					err = err,
				})
			end
		end, args)
		:start()
end

local function sendmany(argslist, cb)
	local results = {}

	for i, args in ipairs(argslist) do
		send(args, function(res)
			results[i] = res
			if i == #argslist then
				cb(results)
			end
		end)
	end
end

-- send({ "query", "--windows", "first" }, function(res)
-- 	log("query ok", {
-- 		res = res,
-- 	})
-- end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "a", function()
	sendmany({
		{ "query", "--windows" },
		{ "query", "--displays" },
		{ "query", "--spaces" },
	}, function(res)
		local windows, displays, spaces = table.unpack(res)
		log("query ok", {
			windows = windows,
			displays = displays,
			spaces = spaces,
		})
	end)
end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "p", function()
	local o = {}
	for _, a in ipairs(hs.application.runningApplications()) do
		o[#o + 1] = {
			name = a:name(),
			title = a:title(),
			bundleId = a:bundleID(),
			pid = a:pid(),
			image = a:bundleID() ~= nil and hs.image.imageFromAppBundle(a:bundleID()) or nil,
		}
	end
	log("applications", o)
end)
