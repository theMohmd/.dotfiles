function StringToLiteral()
    vim.cmd([[normal! ea ${} ]])
    vim.cmd([[normal! "5di"xs{``}]])
    vim.cmd([[normal! h"5P]])
    vim.cmd([[normal! 0f$2l]])
    vim.cmd('startinsert')
end
-- cmd alias vim.cmd([[command! S lua StringToLiteral()]])

vim.keymap.set("n", "<leader>$", function()
    vim.cmd('lua StringToLiteral()')
end)

