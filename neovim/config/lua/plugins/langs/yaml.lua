return {
  {
    "nvim-lint",
    opts = function(_, opts)
      local cfnlint = require("lint").linters.cfn_lint
      vim.list_extend(cfnlint.args, { "--non-zero-exit-code", "none" })
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts["yaml.cloudformation"] = { "cfn_lint" }
      opts["json.cloudformation"] = { "cfn_lint" }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "cfn-lint" } },
  },
  -- Setup cfn-lsp as a custom server
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      local configs = require("lspconfig.configs")
      if not configs.cfnlsp then
        configs.cfnlsp = {
          default_config = {
            cmd = { vim.env.HOME .. "/.local/bin/cfn-lsp-extra" },
            filetypes = { "yaml.cloudformation", "json.cloudformation" },
            root_dir = function(path)
              return require("lspconfig").util.find_git_ancestor(path) or vim.fn.getcwd()
            end,
            settings = {
              documentFormatting = false,
            },
          },
        }
        require("lspconfig").cfnlsp.setup({})
      end
    end,
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        yamlls = {
          filetypes = {
            "yaml",
            "yaml.cloudformation",
            "yaml.docker-compose",
            "yaml.gitlab",
          },
          settings = {
            yaml = {
              customTags = {
                "!And sequence",
                "!If sequence",
                "!Not sequence",
                "!Equals sequence",
                "!Or sequence",
                "!FindInMap sequence",
                "!Base64",
                "!Cidr",
                "!Ref",
                "!Sub",
                "!Sub sequence",
                "!GetAtt",
                "!GetAtt sequence",
                "!GetAZs",
                "!ImportValue",
                "!Select",
                "!Select sequence",
                "!Split",
                "!Join sequence",
              },
            },
          },
        },
      })
    end,
  },
}
