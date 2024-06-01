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
    event = "VeryLazy",
    config = function()
      -- local function hl(name, val)
      --   vim.api.nvim_set_hl(0, name, val)
      -- end

      -- Set highlight groups manually to prevent them from being cleared
      -- hl("HydraRed", { fg = "#FF5733", bold = true, default = true })
      -- hl("HydraBlue", { fg = "#5EBCF6", bold = true, default = true })
      -- hl("HydraAmaranth", { fg = "#ff1757", bold = true, default = true })
      -- hl("HydraTeal", { fg = "#00a1a1", bold = true, default = true })
      -- hl("HydraPink", { fg = "#ff55de", bold = true, default = true })
      -- hl("HydraHint", { link = "NormalFloat", default = true })
      -- hl("HydraBorder", { link = "FloatBorder", default = true })
    end,
  },
}
