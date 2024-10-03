-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require 'custom.keymaps'
require 'custom.options'
require 'custom.config.autocmds'
require('lazy').setup({
  { import = 'custom.plugins' },
  'tpope/vim-sleuth',
  'github/copilot.vim',
  'tpope/vim-fugitive',
  --  require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.gitsigns',
}, {
  change_detection = {
    notify = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
})
