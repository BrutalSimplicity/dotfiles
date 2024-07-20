local M = {}
local LOGGER = hs.logger.new("yabai", LOGLEVEL or "info")
local log = require("objectlogger").wrap(LOGGER)
YabaiPath = "/opt/homebrew/bin/yabai"

local Fn = require("moses")

local function sendmany(argslist, cb)
	assert(type(argslist) == "table" and type(argslist[1]) == "table", "sendmany called with invalid arguments")
	local results = {}

	local function recurse(i)
		M.send(argslist[i], function(res)
			results[#results + 1] = res
			if i == #argslist then
				cb(results)
			else
				recurse(i + 1)
			end
		end)
	end
	recurse(1)
end

function M.send(args, cb)
	assert(args ~= nil and #args > 0, "list of args are required")
	if type(args[1]) == "table" then
		return sendmany(args, cb)
	end
	args = Fn(args):map(tostring):value()
	table.insert(args, 1, "-m")
	log.d("args", args)
	local task
	task = hs.task
		.new(YabaiPath, function(code, out, err)
			task:terminate()
			task = nil
			if code == 0 then
				if cb ~= nil then
					if out ~= nil and out:gsub("%s", "") ~= "" then
						cb(hs.json.decode(out))
					end
				end
			else
				err = {
					cmd = YabaiPath,
					args = args,
					code = code,
					err = err,
				}
				log.e("yabai cmd failed", err)
				if cb ~= nil then
					cb(nil, err)
				end
			end
		end, args)
		:start()
	assert(task ~= false, "task failed to start")
end

function M.focus_window(opts)
	local queries = {
		{ "query", "--windows" },
		{ "query", "--spaces", "--space" },
	}
	M.send(queries, function(res, err)
		log.d("results", res)
		local windows = res[1]
		local activespc = res[2]
		if err ~= nil then
			return
		end
		if windows == nil or #windows <= 1 then
			return
		end
		local activewin = Fn.findWhere(windows, { ["has-focus"] = true })
		log.d("activewin", activewin)
    -- stylua: ignore
		local winstack = Fn(windows)
      :where({ frame = activewin.frame })
      :sortBy("stack-index")
      :value()

		local winselect = opts.dir
		local first = winstack[1]
		local last = winstack[#winstack]
		log.d("winstack", winstack)
		if opts.cycle then
			if opts.dir == "stack.next" then
				winselect = activewin["stack-index"] == last["stack-index"] and first["id"]
					or Fn.findWhere(winstack, { ["stack-index"] = activewin["stack-index"] + 1 })["id"]
			elseif opts.dir == "stack.prev" then
				winselect = activewin["stack-index"] == first["stack-index"] and last["id"]
					or Fn.findWhere(winstack, { ["stack-index"] = activewin["stack-index"] - 1 })["id"]
			end
		end
		M.send({ "window", "--focus", winselect })
	end)
end

return M
