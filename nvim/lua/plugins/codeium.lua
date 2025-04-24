if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {

  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "BufEnter",
  config = function()
    require("codeium").setup {
      enable_cmp_source = true,
      virtual_text = {
        enabled = true,
        manual = false,
        map_keys = true,
        key_bindings = {
          accept = "<C-y>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
    }
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        options = {
          g = {
            -- set the ai_accept function
            ai_accept = function()
              if require("codeium.virtual_text").get_current_completion_item() then
                vim.api.nvim_input(require("codeium.virtual_text").accept())
                return true
              end
            end,
          },
        },
      },
    },
  },
}
