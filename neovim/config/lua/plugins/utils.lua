local function get_cwd_as_name()
  local dir = vim.fn.getcwd(0)
  assert(dir ~= nil)
  return dir:gsub("[^A-za-z0-9]", "_")
end
return {
  {
    "persistence.nvim",
    opts = {
      pre_save = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
      end,
    },
  },
  {
    "wintermute-cell/gitignore.nvim",
    keys = {
      {
        "<leader>gi",
        "<cmd>Gitignore<cr>",
        desc = "Git Ignore",
      },
    },
  },
  -- {
  --   "antoinemadec/FixCursorHold.nvim",
  --   lazy = false,
  --   init = function()
  --     vim.g.cursorhold_updatetime = 50
  --   end,
  -- },
}
