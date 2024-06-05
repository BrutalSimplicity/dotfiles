return {
  -- Auto-completion(LazyVim)
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
      })
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = { { name = "vim-dadbod-completion" } },
      })
      return opts
    end,
  },

  -- Supplies .gitignore templates
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
}
