---@diagnostic disable:missing-fields
return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin-frappe",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      -- custom_highlights = function(colors)
      --   return {
      --     TabLineFill = { bg = colors.crust },
      --     TabLineSel = { bg = colors.base, fg = colors.text, style = { "bold" } },
      --     TabLine = { bg = colors.crust, fg = colors.blue },
      --     BufferVisibleIcon = { fg = colors.green },
      --   }
      -- end,
    },
  },
}
