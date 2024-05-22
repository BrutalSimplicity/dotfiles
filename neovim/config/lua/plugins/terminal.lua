return {
  {
    "aserowy/tmux.nvim",
    keys = {
      {
        "<c-h>",
        function()
          if vim.v.count > 0 then
            return ":wincmd " .. vim.v.count .. "h<cr>"
          else
            return [[<cmd>lua require("tmux").move_left()<cr>]]
          end
        end,
        expr = true,
        desc = "Move to Left Window",
      },
      {
        "<c-l>",
        function()
          if vim.v.count > 0 then
            return ":wincmd " .. vim.v.count .. "l<cr>"
          else
            return [[<cmd>lua require("tmux").move_right()<cr>]]
          end
        end,
        expr = true,
        desc = "Move to Right Window",
      },
      {
        "<c-j>",
        function()
          if vim.v.count > 0 then
            return ":wincmd " .. vim.v.count .. "j<cr>"
          else
            return [[<cmd>lua require("tmux").move_bottom()<cr>]]
          end
        end,
        expr = true,
        desc = "Move to Below Window",
      },
      {
        "<c-k>",
        function()
          if vim.v.count > 0 then
            return ":wincmd " .. vim.v.count .. "k<cr>"
          else
            return [[<cmd>lua require("tmux").move_top()<cr>]]
          end
        end,
        expr = true,
        desc = "Move to Above Window",
      },
    },
    opts = {
      navigation = {
        cycle_navigation = false,
        enable_default_keybindings = false,
        persist_zoom = true,
      },
      resize = {
        enable_default_keybindings = false,
      },
      copy_sync = {
        enable = false,
      },
    },
  },
}
