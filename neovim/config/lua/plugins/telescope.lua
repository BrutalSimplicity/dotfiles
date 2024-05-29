return {

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>lc",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.stdpath("data") .. "/lazy/LazyVim",
          })
        end,
        desc = "LazyVim Configuration",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "prochri/telescope-all-recent.nvim",
        dependencies = {
          "kkharji/sqlite.lua",
        },
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
      ---@diagnostic disable-next-line
      require("telescope-all-recent").setup({})
    end,
  },
}
