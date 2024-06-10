local builtin = require('telescope.builtin')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>cp', builtin.find_files, { desc = 'Alias for search file' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]ile' })
vim.keymap.set('n', '<leader>s?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>s ', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = '[S]earch [g]it repository' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [h]elp' })
vim.keymap.set('n', '<leader>sw', function()
  builtin.grep_string({ search =  vim.fn.expand('<cword>') });
end, { desc = '[S]each by greping current [w]ord' })
vim.keymap.set('n', '<leader>sg', function()
  builtin.grep_string({ search =  vim.fn.input("Grep > ") });
end, { desc = '[S]each by [g]rep' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
