-- Customize the priority of completion items found by LSP
local function lspkind_comparator(conf)
  local lsp_types = require("cmp.types").lsp
  ---@param a cmp.Entry
  ---@param b cmp.Entry
  return function(a, b)
    if a.source.name ~= "nvim_lsp" then
      return b.source.name == "nvim_lsp" and false or nil
    end

    local kinda = lsp_types.CompletionItemKind[a:get_kind()]
    local kindb = lsp_types.CompletionItemKind[b:get_kind()]

    -- Convert variables followed by `=` to named parameters
    if kinda == "Variable" and a:get_completion_item().label:match("%w*=") then
      kinda = "Parameter"
    end
    if kindb == "Variable" and b:get_completion_item().label:match("%w*=") then
      kindb = "Parameter"
    end

    local priority1 = conf.kind_priority[kinda] or 100
    local priority2 = conf.kind_priority[kindb] or 100

    -- Equals is undecided
    if priority1 == priority2 then
      return nil
    end
    return priority1 < priority2
  end
end

return {

  -- Auto-completion(LazyVim)
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local comp = require("cmp.config.compare")
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
      })
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = { { name = "vim-dadbod-completion" } },
      })
      opts.sorting = opts.sorting or {}
      opts.sorting.comparators = {
        lspkind_comparator({
          kind_priority = {
            Parameter = 1,
            Variable = 2,
            Field = 3,
            Property = 3,
            Constant = 4,
            Enum = 4,
            EnumMember = 4,
            Event = 4,
            Function = 4,
            Method = 4,
            Operator = 4,
            Reference = 4,
            Struct = 4,
            File = 6,
            Folder = 6,
            Class = 6,
            Color = 6,
            Module = 6,
            Keyword = 9,
            Constructor = 9,
            Interface = 10,
            Snippet = 100,
            Text = 10,
            TypeParameter = 10,
            Unit = 10,
            Value = 10,
          },
        }),
        comp.sort_text,
      }
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
  {
    "nvim-treesitter-context",
    opts = { enable = false },
  },
}
