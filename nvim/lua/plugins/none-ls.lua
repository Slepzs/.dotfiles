-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"
    local astro = require "astrocore"
    local methods = null_ls.methods

    local prettier_config_files = {
      ".prettierrc",
      ".prettierrc.json",
      ".prettierrc.yaml",
      ".prettierrc.yml",
      ".prettierrc.json5",
      ".prettierrc.js",
      ".prettierrc.cjs",
      ".prettierrc.mjs",
      ".prettierrc.toml",
      "prettier.config.js",
      "prettier.config.cjs",
      "prettier.config.mjs",
      "prettier.config.ts",
      "prettier.config.cts",
    }

    local function has_prettier_config(utils)
      return utils.root_has_file(prettier_config_files)
    end

    local new_sources = {}
    if null_ls.builtins and null_ls.builtins.formatting then
      if null_ls.builtins.formatting.prettierd then
        table.insert(
          new_sources,
          null_ls.builtins.formatting.prettierd.with {
            condition = has_prettier_config,
          }
        )
      end
      if null_ls.builtins.formatting.biome then
        table.insert(
          new_sources,
          null_ls.builtins.formatting.biome.with {
            condition = function(utils)
              return not has_prettier_config(utils)
            end,
          }
        )
      end
    end
    if null_ls.builtins and null_ls.builtins.diagnostics and null_ls.builtins.diagnostics.biome then
      table.insert(
        new_sources,
        null_ls.builtins.diagnostics.biome.with {
          method = methods.DIAGNOSTICS_ON_SAVE,
          condition = function(utils)
            return not has_prettier_config(utils)
          end,
        }
      )
    end
    -- You can also enable code actions if desired:
    -- if null_ls.builtins.code_actions and null_ls.builtins.code_actions.biome then
    --   table.insert(new_sources, null_ls.builtins.code_actions.biome)
    -- end

    if #new_sources > 0 then
      opts.sources = astro.list_insert_unique(opts.sources or {}, new_sources)
    end
  end,
}
