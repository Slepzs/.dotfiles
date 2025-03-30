-- File: ~/.config/nvim/lua/user/plugins/lspconfig.lua

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      denols = {
        root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc", ".git"),
        init_options = {
          lint = true,
          unstable = true,
          suggest = {
            imports = {
              hosts = {
                ["https://deno.land"] = true,
                ["https://cdn.nest.land"] = true,
                ["https://crux.land"] = true,
              },
            },
          },
        },
      },
    },
    setup = {
      denols = function(_, opts)
        local lspconfig = require "lspconfig"
        local util = require "lspconfig.util"

        -- Disable tsserver in Deno projects
        lspconfig.tsserver.setup {
          root_dir = function(fname)
            if util.root_pattern("deno.json", "deno.jsonc")(fname) then return nil end
            return util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(fname)
          end,
        }

        -- Set up denols
        lspconfig.denols.setup(opts)

        -- Set filetype to typescript for Deno files
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
          callback = function()
            if util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then vim.bo.filetype = "typescript" end
          end,
        })
      end,
    },
  },
}
