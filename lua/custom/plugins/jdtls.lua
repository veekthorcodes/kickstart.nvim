return {
  'mfussenegger/nvim-jdtls',
  ft = 'java',
  config = function()
    local on_attach = function(client, bufnr)
      -- You can copy the on_attach function from lspconfig.lua here
      -- or require it from a separate file if you want to share it
    end

    local config = {
      cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        vim.fn.glob '/path/to/jdtls/plugins/org.eclipse.equinox.launcher_*.jar',
        '-configuration',
        '/path/to/jdtls/config_linux',
        '-data',
        vim.fn.expand '~/.cache/jdtls-workspace' .. vim.fn.getcwd(),
      },

      root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew' },

      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = 'fernflower' },
          completion = {
            favoriteStaticMembers = {
              'org.hamcrest.MatcherAssert.assertThat',
              'org.hamcrest.Matchers.*',
              'org.junit.Assert.*',
              'java.util.Objects.requireNonNull',
              'java.util.Objects.requireNonNullElse',
              'org.mockito.Mockito.*',
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
          },
        },
      },

      on_attach = on_attach,
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }

    local jdtls = require 'jdtls'

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      callback = function()
        jdtls.start_or_attach(config)
      end,
    })
  end,
}
