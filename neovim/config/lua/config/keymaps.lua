-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local LazyVim = require("lazyvim.util")
local Util = require("user.util")

---@type user.util.KeymapSpec
local keymaps = {
  -- General operations
  {
    "<leader>Q",
    "<cmd>wa | q<cr>",
    desc = "Write All & Quit",
  },

  -- Movement operations
  -- Super j/k mapping adds additional behaviors to normal j/k:
  -- 1. When there is no count, it uses g<j/k> to ensure the cursor moves to the next visible lines
  -- rather than the next line break (the default behavior).
  -- 2. When given a count, it also adds the line to the jump list for easy navigation with
  -- c-o/c-i
  {
    { "n", "x" },
    "k",
    function()
      return vim.v.count > 1 and "m'" .. vim.v.count .. "k" or "gk"
    end,
    desc = "Super k",
    silent = true,
    expr = true,
  },
  {
    { "n", "x" },
    "j",
    function()
      return vim.v.count > 1 and "m'" .. vim.v.count .. "j" or "gj"
    end,
    desc = "Super j",
    silent = true,
    expr = true,
  },

  -- Lazy operations
  -- Remap lazy.nvim console
  { "<leader>l", Util.DEL },
  { "<leader>ll", "<cmd>Lazy<cr>", desc = "Lazy" },
  { "<leader>lx", "<cmd>LazyExtras<cr>", desc = "LazyVim Extras" },

  { { "n", "i" }, "<C-s>", "<cmd>w<cr>", desc = "Save File" },

  -- Buffer operations
  {
    { "n", "i" },
    "<C-x>",
    LazyVim.ui.bufremove,
    desc = "Delete Buffer",
  },
  -- Remap alternate buffer
  { "<leader>`", Util.DEL },
  {
    "n",
    "<leader>;",
    "<C-6>",
    desc = "Toggle Alternate Buffer",
  },

  -- File operations
  {
    "<leader>fx",
    function()
      local shortpath = vim.fn.expand("%")
      local path = vim.fn.expand("%:p")
      vim.fn.execute("!chmod +x " .. path)
      vim.notify(string.format("%s is now executable!", shortpath), "info")
    end,
    desc = "Make file executable",
  },
  {
    "<leader>W",
    "<cmd>wa<cr>",
    desc = "Write All",
  },

  -- Selection operations
  { "<leader>Y", ":%y<CR>", desc = "Copy All" },

  -- Settings
  {
    "<leader>uy",
    function()
      vim.o.clipboard = vim.o.clipboard == "unnamedplus" and "" or "unnamedplus"
      vim.notify(string.format("Clipboard: %s", vim.o.clipboard))
    end,
    desc = "Toggle OS Clipboard",
  },
}

Util.process_keymap_spec(keymaps)
