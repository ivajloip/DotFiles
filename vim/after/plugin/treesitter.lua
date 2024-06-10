require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { 'c', 'go', 'lua', 'python', 'rust', 'typescript', 'vim' },

  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } }
}
