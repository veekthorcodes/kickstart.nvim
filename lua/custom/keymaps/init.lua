require 'custom.keymaps.java'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- vim.keymap.set('n', '<leader>p', ':Ex <CR>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 'v' }, 'kj', '<Esc>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>wh', ':split<CR>', { desc = 'Horizontal split' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Close window' })

vim.keymap.set('v', '<', '<gv', { desc = 'Shift left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Shift right' })

vim.keymap.set('n', '<leader>l', ':Lazy <CR>', { desc = 'Lazy' })

vim.keymap.set('i', '<C-y>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>rg', ':lua run_gradle()<CR>', { desc = 'Run maven' })
vim.keymap.set('n', '<leader>rj', ':lua run_java()<CR>', { desc = 'Run java' })
