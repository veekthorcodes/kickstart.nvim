return {
  'L3MON4D3/LuaSnip',
  config = function()
    local ls = require 'luasnip'
    local s = ls.snippet
    local t = ls.text_node

    ls.add_snippets('java', {
      s('sout', { t 'System.out.println()' }),
    })
  end,
}
