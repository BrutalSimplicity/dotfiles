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
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.g.miniindentscope_disable = true
      require("mini.indentscope").undraw()

      -- Disable guide line for certain file types and plugins
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
