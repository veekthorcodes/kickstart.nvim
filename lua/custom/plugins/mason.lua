return {
  'williamboman/mason.nvim', -- Manage LSP installations
  dependencies = { 'williamboman/mason-lspconfig.nvim' },
  config = function()
    require('mason').setup()

    require('mason-lspconfig').setup {
      ensure_installed = {
        'jdtls', -- Java LSP
        'lua_ls', -- Lua LSP for Neovim
      },
    }
  end,
}
