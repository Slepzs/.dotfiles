-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"
    local astro = require "astrocore"

    -- Add Biome for formatting and diagnostics instead of Prettier
    local new_sources = {}
    if null_ls.builtins and null_ls.builtins.formatting and null_ls.builtins.formatting.biome then
      table.insert(new_sources, null_ls.builtins.formatting.biome)
    end
    if null_ls.builtins and null_ls.builtins.diagnostics and null_ls.builtins.diagnostics.biome then
      table.insert(new_sources, null_ls.builtins.diagnostics.biome)
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
