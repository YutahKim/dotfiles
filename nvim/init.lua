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
  
  -- Autocomplete
  {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }
        }, {
          { name = 'buffer' },
          { name = 'path' }
        })
      })
    end
  },
  
 -- LSP (Language Server Protocol)
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      
      -- Use ts_ls for TypeScript/JavaScript
      lspconfig.ts_ls.setup {}

      -- Other LSP servers
      lspconfig.html.setup {}
      lspconfig.cssls.setup {}
      lspconfig.jsonls.setup {}
      lspconfig.vuels.setup {}
      lspconfig.pyright.setup {}
    end
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
  {
    'gruvbox-community/gruvbox',
    config = function()
      vim.cmd 'colorscheme gruvbox'
      vim.o.background = 'dark'
    end
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
