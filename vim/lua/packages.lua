vim.cmd([[packadd packer.nvim]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'scrooloose/nerdcommenter'
  use 'mbbill/undotree'
  use 'mileszs/ack.vim'
  use 'bling/vim-airline'
  use 'honza/vim-snippets'
  use 'altercation/vim-colors-solarized'

  -- Experimental plugins
  use 'JamshedVesuna/vim-markdown-preview'
  use 'vim-airline/vim-airline-themes'
  use 'fatih/vim-go'
  use 'rust-lang/rust.vim'
  use 'vimwiki/vimwiki'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    }
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim' } }
  }

  -- old
  -- use 'folke/tokyonight.nvim' -- color schema
end)
