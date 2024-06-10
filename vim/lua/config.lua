-----------------------------------------------------------
-- General
-----------------------------------------------------------
vim.g.mapleader = ","                     -- Remap leader
vim.opt.encoding = "utf-8"
vim.opt.mouse = 'a'                       -- Enable mouse support
vim.opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
vim.opt.swapfile = false                  -- Don't use swapfile
vim.opt.undofile = true                   -- Save Undo history
vim.opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
vim.opt.number = true           -- Show line number
vim.opt.relativenumber = true   -- Show relative line numbers
vim.opt.showmatch = true        -- Highlight matching parenthesis
vim.opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
vim.opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.splitright = true       -- Vertical split to the right
vim.opt.splitbelow = true       -- Horizontal split to the bottom
vim.opt.ignorecase = true       -- Ignore case letters when search
vim.opt.smartcase = true        -- Ignore lowercase for the whole pattern
vim.opt.linebreak = true        -- Wrap on word boundary
vim.opt.laststatus=3            -- Set global statusline
vim.opt.scrolloff = 10 -- start scrolling before reaching end
vim.opt.background = 'dark'

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.shiftwidth = 2          -- Shift 4 spaces when tab
vim.opt.tabstop = 2             -- 1 tab == 4 spaces
vim.opt.softtabstop = 2
vim.opt.smartindent = true      -- Autoindent new lines
vim.opt.shiftround = true
vim.opt.showmatch = true
vim.opt.cindent = true

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
vim.opt.hidden = true           -- Enable background buffers
vim.opt.history = 1000           -- Remember N lines in history
vim.opt.lazyredraw = true       -- Faster scrolling
vim.opt.synmaxcol = 240         -- Max column for syntax highlight
vim.opt.updatetime = 250        -- ms to wait for trigger an event
vim.opt.timeoutlen = 300

----------------------------------------------------------
-- Others
----------------------------------------------------------

vim.opt.wildmode = 'longest:full'
vim.opt.wildmenu = true
vim.opt.keymap = 'bulgarian-bds'
vim.opt.iminsert = 0
vim.opt.imsearch = -1
vim.opt.dir = '/tmp/'

vim.api.nvim_set_hl(0, 'CursorLine', {cterm=bold})
vim.api.nvim_set_hl(0, 'SpellBad', {cterm=unterline, ctermbg=Black, ctermfg=Magenta, gui=underline, guibg=Black, guifg=Magenta})

-- Remove pending whitespace
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.{c,clj,cpp,h,go,hpp,lua,py,rb,rs,tex}',
  command = [[%s/\s\+$//e]],
})

--------------
vim.cmd([[
  set wildignore+=*/.git/*,*.class,*.jar,*.zip,*.d

  let g:airline_theme             = 'luna'
  let g:airline#extensions#syntastic#enabled = 1
  set laststatus=2
]])
