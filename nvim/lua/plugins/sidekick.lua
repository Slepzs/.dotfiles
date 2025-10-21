---@type LazySpec
return {
  {
    "folke/sidekick.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "folke/snacks.nvim", optional = true },
      { "zbirenbaum/copilot.lua", optional = true },
    },
    opts = {
      cli = {
        mux = {
          enabled = false,
          backend = nil,
        },
      },
    },
    keys = {
      {
        "<Tab>",
        function()
          if require("sidekick").nes_jump_or_apply() then
            return vim.api.nvim_replace_termcodes("<Ignore>", true, false, true)
          end
          require("sidekick.nes").update()
          return vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
        end,
        mode = "n",
        expr = true,
        desc = "Sidekick jump/apply next edit",
      },
      {
        "<leader>an",
        function()
          if not require("sidekick").nes_jump_or_apply() then
            require("sidekick.nes").update()
          end
        end,
        mode = { "n", "v" },
        desc = "Sidekick apply next edit suggestion",
      },
      {
        "<leader>aN",
        function()
          require("sidekick").clear()
        end,
        mode = { "n", "v" },
        desc = "Sidekick clear suggestions",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle({ focus = true })
        end,
        mode = { "n", "v" },
        desc = "Sidekick toggle CLI",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").select_prompt()
        end,
        mode = { "n", "v" },
        desc = "Sidekick prompt picker",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").ask({ prompt = "diagnostics", submit = true })
        end,
        mode = { "n", "v" },
        desc = "Sidekick diagnostics prompt",
      },
    },
  },
}
