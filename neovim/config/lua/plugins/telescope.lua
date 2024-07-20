return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>lc",
        require("lazyvim.util").pick("find_files", {
          cwd = vim.fn.stdpath("data") .. "/lazy/LazyVim",
        }),
        desc = "LazyVim Configuration (Find Files)",
      },
      {
        "<leader>lC",
        require("lazyvim.util").pick("live_grep", {
          cwd = vim.fn.stdpath("data") .. "/lazy/LazyVim",
        }),
        desc = "LazyVim Configuration (Grep)",
      },
      {
        "<leader>lp",
        require("lazyvim.util").pick("find_files", {
          cwd = vim.fn.stdpath("data") .. "/lazy",
        }),
        desc = "LazyVim Plugins (Find Files)",
      },
      {
        "<leader>,",
        require("lazyvim.util").pick("buffers", {
          ignore_current_buffer = true,
        }),
        desc = "Find Buffers",
      },
      {
        "<leader>fb",
        require("lazyvim.util").pick("buffers", {
          ignore_current_buffer = true,
        }),
        desc = "Find Buffers",
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
        end,
        desc = "Find Files (Buffer Dir)",
      },
    },
    dependencies = {
      {
        "prochri/telescope-all-recent.nvim",
        dependencies = {
          "kkharji/sqlite.lua",
        },
      },
    },
    opts = {
      defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        layout_strategy = "horizontal",
        winblend = 20,
        layout_config = {
          height = 0.5,
        },
        -- Cache the first 1000 results of all pickers
        cache_pickers = {
          num_pickers = -1,
          limit_entries = 1000,
        },
        preview = {
          hide_on_startup = true,
        },
        mappings = {
          n = {
            ["<c-p>"] = require("telescope.actions.layout").toggle_preview,
          },
          i = {
            ["<c-u>"] = { "<c-s-u>", type = "command" },
            ["<c-j>"] = require("telescope.actions").move_selection_next,
            ["<c-k>"] = require("telescope.actions").move_selection_previous,
            ["<c-p>"] = require("telescope.actions.layout").toggle_preview,
          },
        },
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
