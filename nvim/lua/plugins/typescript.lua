return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      -- Configure tsgo (TypeScript Native) LSP
      handlers = {
        -- Disable biome LSP to avoid duplicate with null-ls biome
        biome = false,
        -- Disable default ts_ls handler since we're using tsgo
        ts_ls = false,
        -- Set up tsgo as custom LSP server
        tsgo = function(_, opts)
          local lspconfig = require "lspconfig"
          local configs = require "lspconfig.configs"

          -- Define tsgo config if not already defined
          if not configs.tsgo then
            configs.tsgo = {
              default_config = {
                cmd = { "tsgo", "--lsp", "--stdio" },
                filetypes = {
                  "javascript",
                  "javascriptreact",
                  "javascript.jsx",
                  "typescript",
                  "typescriptreact",
                  "typescript.tsx",
                },
                root_dir = lspconfig.util.root_pattern(
                  "tsconfig.json",
                  "jsconfig.json",
                  "package.json",
                  ".git",
                  "tsconfig.base.json"
                ),
                settings = {},
              },
            }
          end

          -- Setup tsgo with AstroNvim integration
          lspconfig.tsgo.setup {
            on_attach = function(client, bufnr)
              if opts.on_attach then opts.on_attach(client, bufnr) end
              -- Prefer Biome/none-ls for formatting
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end,
            capabilities = opts.capabilities,
          }

          return true -- signal AstroLSP that we handled setup
        end,
      },
      -- Disable LSP formatting from TypeScript to prefer Biome/none-ls
      formatting = {
        disabled = { "tsgo", "ts_ls" },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = { "biome" }, -- ensure Biome is available
    },
  },
}
