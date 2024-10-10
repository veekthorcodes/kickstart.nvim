return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    local google_java_format = {
      method = null_ls.methods.FORMATTING,
      filetypes = { 'java' },
      generator = {
        fn = function(params)
          local output = vim.fn.system({ 'google-java-format', '--aosp', '-' }, params.content)
          if vim.v.shell_error ~= 0 then
            print('google-java-format error: ' .. output)
            return
          end
          return { { text = output } }
        end,
      },
    }

    null_ls.setup {
      sources = {
        google_java_format,
        -- Add other formatters or linters here as needed
      },
      debug = true, -- Enable debug mode for troubleshooting
    }

    -- Set up autoformatting on save for Java files
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.java',
      callback = function()
        vim.lsp.buf.format { timeout_ms = 10000 }
      end,
    })
  end,
}
