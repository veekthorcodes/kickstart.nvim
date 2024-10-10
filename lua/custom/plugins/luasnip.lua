return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local luasnip = require 'luasnip'

    luasnip.config.set_config {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
    }

    require('luasnip.loaders.from_vscode').lazy_load()

    -- You can add custom snippets here
    -- luasnip.add_snippets("all", {
    --   luasnip.snippet("expand", {
    --     luasnip.text_node("-- This is a custom snippet")
    --   })
    -- })

    vim.keymap.set({ 'i', 's' }, '<C-k>', function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-j>', function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true })

    vim.keymap.set('i', '<C-l>', function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end)
  end,
}
