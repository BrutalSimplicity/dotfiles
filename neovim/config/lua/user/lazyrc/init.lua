local function find_workspace_dir(path)
  local workspace_path = find_workspace_path(path)
  return workspace_path and vim.fs.dirname(workspace_path) or nil
end

local function find_lazyrc(path)
  path = vim.fs.normalize(path)
  if path == basedir then
    return nil
  end
  local filepath = path .. "/" .. workspace_file
  if path[#path] == "/" then
    filepath = path .. workspace_file
  end
  local fp = io.open(filepath, "rb")
  if fp ~= nil then
    fp:close()
    return filepath
  end
  return find_lazyrc(vim.fs.dirname(path))
end

local function merge_with_lazy_config(path, opts)
  local workspace_path = find_lazyrc(path)
  if workspace_path == nil then
    return opts
  end
  local workspace_spec = loadfile(workspace_path)()
  local plugins = workspace_spec.plugins
  local keys = workspace_spec.keys
  local setup = workspace_spec.setup
  local events = workspace_spec.events
  if plugins ~= nil then
    vim.list_extend(opts.spec, plugins)
  end
  if keys ~= nil then
    for _, mapping in ipairs(keys) do
      vim.keymap.set(unpack(mapping))
    end
  end
  if events ~= nil then
    local group = vim.api.nvim_create_augroup("Workspace", { clear = true })
    for _, event in ipairs(events) do
      event[2].group = group
      vim.api.nvim_create_autocmd(unpack(event))
    end
  end
  vim.api.nvim_create_augroup("Workspace#LazyEvent", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      if setup ~= nil then
        setup()
      end
    end,
  })
  return opts
end
return {}
