local icons = require("lazyvim.config").icons

return {
  -- bufferline(LazyVim): Buffers as tabs
  {
    "bufferline.nvim",
    keys = {
      {
        "<leader>bb",
        "<cmd>BufferLinePick<cr>",
        desc = "Select Buffer",
      },
      {
        "<leader>bc",
        "<cmd>BufferLinePickClose<cr>",
        desc = "Select Buffer to Close",
      },
      {
        "<leader>;",
        "<C-6>",
        desc = "Toggle Alternate Buffer",
      },
    },
  },
  -- lualine(LazyVim): Replace standard status line
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        globalstatus = true,
      },
      sections = {
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
        },
      },
      winbar = {
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 2, right = 0 },
          },
          { "filename", path = 3, shorting_target = 40 },
        },
      },
      inactive_winbar = {
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 2, right = 0 },
          },
          { "filename", path = 5 },
        },
      },
    },
  },

  -- Mini.IndenScope(LazyVim): Scoped Indent Guide Line
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        animation = function()
          return 0
        end,
      },
    },
  },
}
