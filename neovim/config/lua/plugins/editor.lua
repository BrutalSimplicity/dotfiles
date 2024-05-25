return {
  -- Neotree(LazyVim): file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<c-e>",
        function()
          require("neo-tree.command").execute({ action = "focus" })
        end,
      },
    },
  },

  -- Mini.Files(LazyVim): vim-like file manpulation
  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = false,
        width_preview = 80,
      },
      options = {
        permanent_delete = false,
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      local preview_enabled = opts.windows.preview

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local mini_buf_id = args.data.buf_id
          vim.keymap.set("n", "<esc>", function()
            require("mini.files").close()
          end, { desc = "Close", buffer = mini_buf_id })
          vim.keymap.set("n", "<c-p>", function()
            require("mini.files").refresh({
              windows = {
                preview = not preview_enabled,
              },
            })
            preview_enabled = not preview_enabled
          end, { desc = "Toggle Preview", buffer = mini_buf_id })
        end,
      })

      -- Notify LSP of rename
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          require("lazyvim.util").lsp.on_rename(event.data.from, event.data.to)
        end,
      })
    end,
  },

  -- flash(LazyVim): Easy Motions
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = true,
          keys = { "f", "F", "t", "T" },
          char_actions = function(motion)
            return {
              [motion:lower()] = "next",
              [motion:upper()] = "prev",
            }
          end,
          highlight = { backdrop = false },
        },
      },
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>ha",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>hh",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },

  -- Neogit: An integrated Git workflow plugin
  {
    "NeogitOrg/neogit",
    dependencies = {
      "sindrets/diffview.nvim",
      "plenary.nvim",
      "telescope.nvim",
    },
    config = true,
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
        desc = "Open Neogit",
      },
      {
        "<leader>gC",
        function()
          require("neogit").open({ "commit" })
        end,
        desc = "Neogit Commit",
      },
    },
  },

  -- Multi-cursor plugin (best I've been able to find)
  {
    "mg979/vim-visual-multi",
  },
  {
    "yanky.nvim",
    keys = {
      {
        "<leader>yh",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Open Yank History",
      },
    },
  },
}
