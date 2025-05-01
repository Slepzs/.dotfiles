-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",

        -- "copilot-language-server",

        -- install formatters
        -- "stylua",

        -- install debuggers
        -- "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      handlers = {
        prettier = function() end, -- Disable prettier completely
        prettierd = function()
          require("null-ls").register(require("null-ls").builtins.formatting.prettierd.with {
            condition = function(utils)
              return utils.root_has_file "apps/web/.prettierrc"
                or utils.root_has_file "apps/web/.prettierrc.yml"
                or utils.root_has_file "apps/web/.prettierrc.js"
                or utils.root_has_file ".prettierrc"
            end,
          })
        end, -- Disable prettierd completely
        biome = function()
          require("null-ls").register(require("null-ls").builtins.formatting.biome.with {
            condition = function(utils)
              return utils.root_has_file "apps/web/biome.json"
                or utils.root_has_file "biome.json"
                or utils.root_has_file "apps/ecommerce/biome.json"
            end,
          })
        end,
      },
    },
  },
}
