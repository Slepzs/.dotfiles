-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  "saghen/blink.cmp",
  optional = true,
  opts = function(_, opts)
    if not opts.keymap then opts.keymap = {} end
    opts.keymap["<Tab>"] = {
      "snippet_forward",
      function()
        local ok, sidekick = pcall(require, "sidekick")
        if ok then return sidekick.nes_jump_or_apply() end
      end,
      function()
        if vim.g.ai_accept then return vim.g.ai_accept() end
      end,
      function()
        if vim.lsp and vim.lsp.inline_completion then
          local completion = vim.lsp.inline_completion.get()
          if completion then return completion end
        end
      end,
      "fallback",
    }
    opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }
  end,
}
