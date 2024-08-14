M = {}

---@alias MapMode
---| 'n'   Normal
---| 'v'   Visual and Select
---| 's'   Select
---| 'x'   Visual
---| 'o'   Operator-pending
---| 'm'   Insert and Command-line
---| 'i'   Insert
---| 'l'   Insert, Command-line, Lang-Arg
---| 'c'   Command-line
---| 't'   Terminal
---@class user.util.SetKeymapShortSpec : vim.keymap.set.Opts
---@field [1] string
---@field [2] string | function
---
---@class user.util.SetKeymapSpec : vim.keymap.set.Opts
---@field [1] MapMode | MapMode[]
---@field [2] string
---@field [3] string | function
---
---@class user.util.DelKeymapShortSpec : vim.keymap.del.Opts
---@field [1] user.util.DelKeymapId
---@field [2] string
---
---@class user.util.DelKeymapSpec : vim.keymap.del.Opts
---@field [1] user.util.DelKeymapId
---@field [2] MapMode | MapMode[]
---@field [3] string
---
---@class user.util.ToggleKeymapSpec
---@field [1] user.util.ToggleKeymapId
---@field [2] string
---@field [3] lazyvim.Toggle

---@alias user.util.Keymap
--- |user.util.SetKeymapSpec
--- |user.util.SetKeymapShortSpec
--- |user.util.DelKeymapSpec
--- |user.util.DelKeymapShortSpec
--- |user.util.ToggleKeymapSpec

---@alias user.util.KeymapSpec user.util.Keymap[]

---@class user.util.DelKeymapId
M.DEL = {}
---@class user.util.ToggleKeymapId
M.TOGGLE = {}

local function process_keymap(pos_args, kwd_args)
  local fst = pos_args[1]
  if pos_args[1] == M.DEL or pos_args[1] == M.TOGGLE then
    table.remove(pos_args, 1)
  end

  -- Redirect toggle specs to LazyVim handler
  if fst == M.TOGGLE then
    require("lazyvim.util").toggle.map(unpack(pos_args))
    return
  end
  -- Handle both vim.keymap.set and vim.keymap.del

  -- Handle the optional mode positional argument. If we only have the 2
  -- required arguments, then assume mode was left out and
  -- default to "normal"
  if #pos_args < 3 then
    table.insert(pos_args, 1, "n")
  end

  local handler = vim.keymap.set
  if fst ~= M.DEL then
    -- Defaults silent to false, if not set
    kwd_args.silent = kwd_args.silent ~= false
  else
    -- Remove the boolean flag to match the keymap.del parameters
    handler = vim.keymap.del
  end

  -- Add keyword arguments into the last element of the position
  -- to match the keymap.set functions parameters
  pos_args[#pos_args + 1] = kwd_args
  handler(unpack(pos_args))
end

-- Process keymap spec the same way lazy.nvim does (I think)
---@param spec user.util.KeymapSpec
function M.process_spec(spec)
  for _, mapping in ipairs(spec) do
    -- handle keyword and position arguments separately
    local kwd_args = {}
    local pos_args = {}
    for k, v in pairs(mapping) do
      if string.find(k, "^%d") then
        pos_args[#pos_args + 1] = v
      else
        kwd_args[k] = v
      end
    end
    process_keymap(pos_args, kwd_args)
  end
end

local function get_handler_index(mapping)
  local _, _, third = mapping[1], mapping[2], mapping[3]
  return third == nil and 2 or 3
end

function M.find_lazy_keymap(keys, spec)
  for _, mapping in ipairs(spec) do
    local handler_index = get_handler_index(mapping)
    if mapping[handler_index - 1] == keys then
      return mapping
    end
  end
end

function M.remap_lazy_key(from, to, spec)
  local _tmp = M.find_lazy_keymap(from, spec)
  local handler_index = get_handler_index(_tmp)
  _tmp[handler_index - 1] = to
end

return M
