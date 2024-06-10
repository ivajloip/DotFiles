local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ 'numToStr/Comment.nvim', opts = {} },
	'scrooloose/nerdcommenter',
	'mbbill/undotree',
	'mileszs/ack.vim',
	'bling/vim-airline',
	'honza/vim-snippets',

	-- Experimental plugins
	'JamshedVesuna/vim-markdown-preview',
	'vim-airline/vim-airline-themes',
	'fatih/vim-go',
	'rust-lang/rust.vim',
	'vimwiki/vimwiki',
	{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    }
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { {'nvim-lua/plenary.nvim' } }
  }
})
