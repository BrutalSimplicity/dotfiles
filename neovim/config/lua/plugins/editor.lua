local Keymap = require("user.util.keymap")

local function yank_icon(bufnr)
  local entry = require("telescope.actions.state").get_selected_entry()

  if not entry then
    vim.notify("yank_selection", {
      msg = "Nothing currently selected",
      level = "WARN",
    })
    return
  end

  local split = vim.split(entry.value, " ")

  vim.schedule(function()
    vim.cmd("let @\"='" .. split[1] .. "'")
  end)
  require("telescope.actions").close(bufnr)
end

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
  {
    "echasnovski/mini.align",
    event = "VeryLazy",
    version = "*",
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
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
        {
          "<leader>yh",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list("yeet"))
          end,
          desc = "Harpoon Yeet Menu",
        },
      }

      for i = 1, 4 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      for i = 1, 4 do
        table.insert(keys, {
          string.format("<leader><F%s>", i),
          function()
            require("harpoon"):list("yeet"):select(i - 5)
          end,
          desc = "Yeet command " .. i,
        })
      end

      return keys
    end,
    config = function(_, opts)
      local h = require("harpoon")
      h:setup(vim.tbl_extend("force", opts, {
        yeet = {
          select = function(i, _, _)
            local yeet = require("yeet")
            yeet._cmd = i.value
            require("yeet").execute(i.value)
          end,
        },
      }))
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
        "<leader>p",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Open Yank History",
      },
    },
  },

  -- Dial: Increment/Decrement symbols
  {
    "dial.nvim",
    keys = function(_, keys)
      -- Remap increment/decrement to Meta (alt/option) to avoid tmux
      -- prefix-key (ctrl-a) conflict
      Keymap.remap_lazy_key("<C-a>", "<M-a>", keys)
      Keymap.remap_lazy_key("<C-x>", "<M-x>", keys)
      Keymap.remap_lazy_key("g<C-a>", "g<M-a>", keys)
      Keymap.remap_lazy_key("g<C-x>", "g<M-x>", keys)
    end,
    opts = function(_, opts)
      local augend = require("dial.augend")
      opts.groups.python[#opts.groups.python + 1] = augend.constant.new({
        elements = { "and", "or" },
        word = true,
        cyclic = true,
      })
      opts.groups.toml = {
        augend.integer.alias.decimal,
        augend.semver.alias.semver,
      }
      opts.dials_by_ft = {
        toml = "toml",
      }
    end,
  },

  {
    "ziontee113/icon-picker.nvim",
    dependencies = {
      {
        "dressing.nvim",
        opts = {
          select = {
            get_config = function(opts)
              if opts.kind == "icon_picker" then
                return {
                  telescope = {
                    attach_mappings = function(_, map)
                      map({ "i", "n" }, "<c-y>", yank_icon)
                      return true
                    end,
                  },
                  -- telescope = {
                  --   defaults = {
                  --     mappings = {
                  --       n = {
                  --         ["y"] = yank_selection,
                  --       },
                  --     },
                  --   },
                  -- },
                }
              end
            end,
          },
        },
      },
    },
    cmd = {
      "IconPickerNormal",
    },
    keys = {
      {
        "<leader>fi",
        "<cmd>IconPickerNormal<cr>",
        desc = "Find Icon",
      },
    },
    config = function(_, opts)
      require("icon-picker").setup(opts or {})
    end,
  },
  {
    "mizlan/iswap.nvim",
    dependencies = {
      {
        "which-key.nvim",
        opts = {
          spec = {
            { "<leader>ci", name = "+iswap", group = "iswap" },
          },
        },
      },
    },
    event = "VeryLazy",
    keys = {
      { "<leader>ciw", "<cmd>ISwapWith<cr>", desc = "Swap With" },
      { "<leader>cil", "<cmd>ISwapWithLeft<cr>", desc = "Swap With Left" },
      { "<leader>cir", "<cmd>ISwapWithRight<cr>", desc = "Swap With Right" },
      { "<leader>cim", "<cmd>IMoveWith<cr>", desc = "Move With" },
    },
  },
}
