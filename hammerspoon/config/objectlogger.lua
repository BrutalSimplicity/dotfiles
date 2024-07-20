local M = {}
---@param logger hs.logger
function M.wrap(logger)
	local N = {
		d = function(key, obj)
			logger.d(string.format("%s: %s", key, hs.inspect(obj)))
		end,
		e = function(key, obj)
			logger.e(string.format("%s: %s", key, hs.inspect(obj)))
		end,
		i = function(key, obj)
			logger.i(string.format("%s: %s", key, hs.inspect(obj)))
		end,
	}
	return N
end
return M
