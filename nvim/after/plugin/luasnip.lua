require("luasnip.loaders.from_vscode").lazy_load()

local ls = require('luasnip')

-- Define your keybinding to jump to the next placeholder
vim.api.nvim_set_keymap('i', '<C-j>', '<cmd>lua require("luasnip").jump(1)<CR>', { noremap = true, silent = true })

vim.keymap.set({"i", "s"}, "<C-k>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, {silent = true})


