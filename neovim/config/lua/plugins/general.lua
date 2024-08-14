local exec_onwrite = false

return {
  -- Hydra: Multi-modal keymap menus
  {
    "nvimtools/hydra.nvim",
  },

  -- Yeet: Send commands to tmux
  {
    "samharju/yeet.nvim",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
      },
    },
    cmd = "Yeet",
    keys = {
      {
        -- Open target selection
        "<leader>yt",
        function()
          require("yeet").select_target()
        end,
        desc = "Select target pane",
      },
      {
        -- Update yeeted command
        "<leader>yc",
        function()
          require("yeet").set_cmd()
        end,
        desc = "Select target pane",
      },
      {
        "<leader>yo",
        function()
          require("yeet").toggle_post_write()
          exec_onwrite = exec_onwrite == true and false or true
          vim.notify("Execute After Write " .. exec_onwrite and "Enabled" or "Disabled")
        end,
        desc = "Toggle Execute After Write",
      },
      {
        "<leader>yx",
        function()
          require("yeet").execute()
        end,
        desc = "Execute",
      },
      {
        "<leader>yX",
        function()
          require("yeet").execute(nil, { clear_before_yeet = false })
        end,
        desc = "Clear & Execute",
      },
      {
        "<leader><cr>",
        function()
          require("yeet").execute()
        end,
        desc = "Yeet: Execute",
      },
      {
        "<leader>yh",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list("yeet"))
        end,
        desc = "Harpoon Yeet Menu",
      },
    },
  },
}
