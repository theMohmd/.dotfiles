return {
  'hrsh7th/nvim-cmp',
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local tailwind_format = require('tailwind-tools.cmp').lspkind_format

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-l>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping(function()
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-g>", true, false, true))
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("u", true, false, true))
          cmp.confirm({ select = true })
        end)
      },
      formatting = {
        format = function(entry, vim_item)
          vim_item = tailwind_format(entry, vim_item)
          return lspkind.cmp_format()(entry, vim_item)
        end,
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
      })
    })
  end,
}
