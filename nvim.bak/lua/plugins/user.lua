---@type LazySpec
return {
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {},
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    },
    config = function(_, opts) require("lsp_signature").setup(opts) end,
  },
  -- "supermaven-inc/supermaven-nvim",
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function()
  --     require("supermaven-nvim").setup {
  --       keymaps = {
  --         accept_suggestion = "<C-y>",
  --         clear_suggestion = "<C-]>",
  --         accept_word = "<C-h>",
  --       },
  --       ignore_filetypes = { cpp = true },
  --       color = {
  --         cterm = 244,
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "milanglacier/minuet-ai.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("minuet").setup {
  --       provider_options = {
  --         gemini = {
  --           model = "gemini-2.0-flash",
  --           stream = true,
  --           api_key = "AIzaSyBosBgcNBxMAcDnXt0MIKDXUpWaeFQ5MQo",
  --           optional = {
  --             generationConfig = {
  --               maxOutputTokens = 256,
  --             },
  --             safetySettings = {
  --               {
  --                 -- HARM_CATEGORY_HATE_SPEECH,
  --                 -- HARM_CATEGORY_HARASSMENT
  --                 -- HARM_CATEGORY_SEXUALLY_EXPLICIT
  --                 category = "HARM_CATEGORY_DANGEROUS_CONTENT",
  --                 -- BLOCK_NONE
  --                 threshold = "BLOCK_ONLY_HIGH",
  --               },
  --             },
  --           },
  --         },
  --       },
  --
  --       -- Your configuration options here
  --       virtualtext = {
  --         auto_trigger_ft = {},
  --         keymap = {
  --           -- accept whole completion
  --           accept = "<A-A>",
  --           -- accept one line
  --           accept_line = "<A-a>",
  --           -- accept n lines (prompts for number)
  --           -- e.g. "A-z 2 CR" will accept 2 lines
  --           accept_n_lines = "<A-z>",
  --           -- Cycle to prev completion item, or manually invoke completion
  --           prev = "<A-[>",
  --           -- Cycle to next completion item, or manually invoke completion
  --           next = "<A-]>",
  --           dismiss = "<A-e>",
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
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
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/Obsidian",
        },
      },

      -- see below for full list of options 👇
    },
  },
}
