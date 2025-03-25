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
              ensure_installed = { "ts_ls", "pyright", "html", "cssls", "lua_ls" }
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
   -- Autocomplete setup
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
   -- LSP (Language Server Protocol)
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
              local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
        ui = { border = "rounded" }, -- Rounded corners for popups
        hover = { max_width = 0.7 }, -- Adjust hover window size
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
        }
      }
    end
  },
  
  -- Treesitter for better syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "javascript", "typescript", "html", "css", "json", "lua", "python", "vue" },
        highlight = {
          enable = true,
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
      vim.g.material_style = "deep ocean" -- Options: darker, lighter, oceanic, palenight, deep ocean
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
          background = false,
          term_colors = false,
          eob_lines = false,
        },
        high_visibility = {
          lighter = false,
          darker = false,
        },
        lualine_style = "default", -- Options: default, stealth
        async_loading = true,
      })
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
  {
    'akinsho/bufferline.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {}
    end
  },
  
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
        default = true;  -- Enable default icons
      }
    end
  },

   -- Persistence plugin
  {
    'folke/persistence.nvim',
    config = function()
      require('persistence').setup({
        dir = vim.fn.stdpath("data") .. "/sessions/", -- Directory where session files are saved
        options = { "buffers", "curdir", "tabpages", "winsize" }, -- Options to save
      })
      -- Auto-load the session if one exists for the current directory
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 then
            require('persistence').load({ last = true })
          end
        end,
      })
    end
  },
  -- Start screen
  {
  'goolord/alpha-nvim',
  requires = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local startify = require('alpha.themes.startify')
    startify.nvim_web_devicons = false  -- Ensure icons are enabled
    require('alpha').setup(startify.config)
  end
  }
})
