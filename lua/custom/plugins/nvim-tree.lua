return {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'kyazdani42/nvim-web-devicons',
    'kyazdani42/nvim-tree.lua',
  },
  config = function()
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
    require('nvim-tree').setup {
      disable_netrw = true,
      hijack_netrw = true,
      open_on_tab = false,
      hijack_cursor = false,
      update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
      },
      system_open = {
        cmd = nil,
        args = {},
      },
      view = {
        width = 30,
        side = 'left',
      },
    }
  end,
}
