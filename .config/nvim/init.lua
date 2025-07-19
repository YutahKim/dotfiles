require('yutah.mappings')
require('yutah.settings')

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- File tree
  {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup()
    end
  },

  -- Add Mason to your plugin list
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "pyright", "html", "cssls", "lua_ls", "clangd" }
      })
    end
  },
  -- LuaSnip for snippets
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip').setup({
        -- Add any desired configuration here
      })
      -- Load snippets from friendly-snippets or your own snippets
      require('luasnip.loaders.from_vscode').lazy_load()
    end
  },

  --Autocomplete setup
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' }
        })
      })
    end
  },
  --LSP (Language Server Protocol)
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Common on_attach function
      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      end

      -- Setup servers
      local servers = { "ts_ls", "pyright", "html", "cssls", "lua_ls" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end
  },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = { "nvim-lspconfig", "nvim-treesitter", "nvim-web-devicons" },
    config = function()
      require("lspsaga").setup({
        ui = { border = "rounded" },          -- Rounded corners for popups
        hover = { max_width = 0.7 },          -- Adjust hover window size
        symbol_in_winbar = { enable = true }, -- Show current function in winbar
      })

      -- Keybindings
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Show function/variable info" })
      vim.keymap.set("n", "<leader>sh", "<cmd>Lspsaga signature_help<CR>", { desc = "Show function parameters" })
      vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Actions" })
      vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Rename Symbol" })
      vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Go to Definition" })
      vim.keymap.set("n", "<leader>gr", "<cmd>Lspsaga finder<CR>", { desc = "Find References" })
    end,
  },
  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
        extensions = {
          project = {
            base_dirs = {
              { "~/Documents/", max_depth = 2 },
              { "~/.config",    max_depth = 2 },
            },
            hidden_files = true,
          },
        },
      }
    end
  },

  -- {
  --   "ahmedkhalf/project.nvim",
  --   config = function()
  --     require("project_nvim").setup()
  --   end,
  -- },
  {
    "mbbill/undotree"
  },
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("project")
    end,
  },

  -- Treesitter for better syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "javascript", "typescript", "html", "css", "json", "lua", "python", "vue", "markdown", "markdown_inline", "vim", "vimdoc" },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'markdown' },
        },
      }
    end
  },

  -- Git integration
  {
    'tpope/vim-fugitive',
  },

  -- Git signs
  {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox',
        }
      }
    end
  },

  -- Colorscheme
  --  {
  --   'gruvbox-community/gruvbox',
  --  config = function()
  --    vim.cmd 'colorscheme gruvbox'
  --    vim.o.background = 'dark'
  --   end
  -- },

  -- Material (Clean, minimal dark theme)
  {
    "marko-cerovac/material.nvim",
    priority = 1000,
    config = function()
      vim.g.material_style = "darker" -- Options: darker, lighter, oceanic, palenight, deep ocean
      require("material").setup({
        contrast = {
          terminal = false,
          sidebars = false,
          floating_windows = false,
          cursor_line = false,
          non_current_windows = false,
          filetypes = {},
        },
        styles = {
          comments = { italic = true },
          strings = { --[[ bold = true ]] },
          keywords = { --[[ underline = true ]] },
          functions = { --[[ bold = true, undercurl = true ]] },
          variables = {},
          operators = {},
          types = {},
        },
        plugins = {
          "gitsigns",
          "nvim-cmp",
          "telescope",
          "which-key",
        },
        disable = {
          colored_cursor = false,
          borders = false,
          background = true,
          term_colors = false,
          eob_lines = false,
        },
        high_visibility = {
          lighter = false,
          darker = true,
        },
        lualine_style = "default", -- Options: default, stealth
        async_loading = true,
      })
      vim.cmd("colorscheme material")
    end,
  },
  -- Auto pairs for brackets and quotes
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  },

  -- Commenting utility
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- Bufferline for tab-like buffers
  -- {
  --   'akinsho/bufferline.nvim',
  --   requires = 'nvim-tree/nvim-web-devicons',
  --   config = function()
  --     require('bufferline').setup {}
  --   end
  -- },

  -- Indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup {
        indent = { char = '│' },
        scope = { enabled = false },
      }
    end
  },

  -- Web devicons for file icons
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {
        default = true, -- Enable default icons
      }
    end
  },

  -- Persistence plugin
  -- {
  --   'folke/persistence.nvim',
  --   config = function()
  --     require('persistence').setup({
  --       dir = vim.fn.stdpath("data") .. "/sessions/", -- Directory where session files are saved
  --       options = { "buffers", "curdir", "tabpages", "winsize" }, -- Options to save
  --     })
  --     -- Auto-load the session if one exists for the current directory
  --     vim.api.nvim_create_autocmd("VimEnter", {
  --       callback = function()
  --         if vim.fn.argc() == 0 then
  --           require('persistence').load({ last = true })
  --         end
  --       end,
  --     })
  --   end
  -- },

  --Which-key for binding preview
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  --easy navigation by searching words
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  --Search and replace
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require('grug-far').setup({
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' or 'astgrep-rules' can
        -- be specified
      });
    end
  },

  --For commentary
  {
    "tpope/vim-commentary",
    event = "VeryLazy",
  },

  --Better command line
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      presets = {
        bottom_search = true, -- example preset
        command_palette = true,
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#1a1b26", -- Change this to match your theme
      })
    end,
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        config = {
          shortcut = {
            -- action can be a function type
            { desc = string, group = 'highlight group', key = 'shortcut key', action = 'action when you press key' },
          },
          packages = { enable = true }, -- show how many plugins neovim loaded
          -- limit how many projects list, action when you press key or enter it will run this action.
          -- action can be a function type, e.g.
          -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
          project = { enable = true, limit = 8, icon = 'your icon', label = '', action = 'Telescope find_files cwd=' },
          mru = { enable = true, limit = 10, icon = 'your icon', label = '', cwd_only = false },
          footer = {}, -- footer
        }
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },

  --Prettier plugin
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,

          -- Python
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,

          -- C, C++
          null_ls.builtins.formatting.clang_format,
        },
      })
    end,
  },

  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- configuration goes here
    },
  },
  {
    "lervag/wiki.vim",
    -- tag = "v0.10", -- uncomment to pin to a specific release
    init = function()
      -- wiki.vim configuration goes here, e.g.
    end
  },

  --Markdown render
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  {
    "alex-popov-tech/store.nvim",
    dependencies = {
      "OXY2DEV/markview.nvim", -- optional, for pretty readme preview / help window
    },
    cmd = "Store",
    keys = {
      { "<leader>s", "<cmd>Store<cr>", desc = "Open Plugin Store" },
    },
    opts = {
      -- optional configuration here
    },
  },

  -- Start screen
  {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require('alpha.themes.startify')
      startify.nvim_web_devicons = false -- Ensure icons are enabled
      require('alpha').setup(startify.config)
    end
  },

})
