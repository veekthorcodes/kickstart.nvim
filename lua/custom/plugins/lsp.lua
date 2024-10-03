return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    -- Install LSP servers automatically
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'lua_ls', -- Lua
        'ts_ls', -- TypeScript/JavaScript
        'pyright', -- Python
        'html', -- HTML
        'cssls', -- CSS
        'jsonls', -- JSON
        'yamlls', -- YAML
        'bashls', -- Bash
        'jdtls', -- Java
      },
    }

    local lspconfig = require 'lspconfig'

    -- Common LSP settings
    local on_attach = function(client, bufnr)
      local buf_map = function(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
      end

      -- Key mappings for LSP
      buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
      buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
      buf_map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
      buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
      buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
      buf_map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
      buf_map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      buf_map('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>')

      -- Additional settings
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_command [[augroup LspFormatting]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = true })]]
        vim.api.nvim_command [[augroup END]]
      end
    end

    -- Set up servers
    local servers = { 'lua_ls', 'ts_ls', 'pyright', 'html', 'cssls', 'jsonls', 'yamlls', 'bashls' }

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
      }
    end

    -- jdtls configuration (Java)
    lspconfig.jdtls.setup {
      cmd = { 'jdtls' },
      on_attach = on_attach,
      root_dir = function()
        return vim.fs.dirname(vim.fs.find({ '.gradle', '.git', 'mvnw', 'pom.xml' }, { upward = true })[1])
      end,
      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = 'fernflower' }, -- Use fernflower for decompilation
          saveActions = { organizeImports = true },
        },
      },
    }

    -- Lua settings for Neovim development
    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }

    lspconfig.yamlls.setup {
      settings = {
        yaml = {
          schemaStore = {
            enable = true,
            url = 'https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/versions/versions.json',
          },
          schemas = {
            ['https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json'] = '/*.yaml',
          },
        },
      },
    }
  end,
}
