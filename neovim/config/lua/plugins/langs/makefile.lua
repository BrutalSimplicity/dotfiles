return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "make" })
    end,
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "checkmake" })
    end,
  },
  {
    "nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      -- Project is in early stages and missing ability
      -- to specify ignore rules within files
      -- opts.linters_by_ft.make = { "checkmake" }
    end,
  },
}
