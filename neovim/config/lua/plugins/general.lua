return {
  -- Persistence(LazyVim): Session Manager
  {
    "persistence.nvim",
    opts = {
      pre_save = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
      end,
    },
  },

  -- Hydra: Multi-modal keymap menus
  {
    "anuvyklack/hydra.nvim",
  },
}
