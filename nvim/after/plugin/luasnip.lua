require("luasnip.loaders.from_vscode").lazy_load()

--local luasnip = require('luasnip')

-- Define your keybinding to jump to the next placeholder
vim.api.nvim_set_keymap('i', '<C-j>', '<cmd>lua require("luasnip").jump(1)<CR>', { noremap = true, silent = true })



