function StringToLiteral()
    vim.cmd([[normal! Ea ${} ]])
    vim.cmd([[normal! 0f"s{`]])
    vim.cmd([[normal! $F"s`}]])
    vim.cmd([[normal! 0f$2l]])
    vim.cmd('startinsert')
end
-- cmd alias vim.cmd([[command! S lua StringToLiteral()]])

vim.keymap.set("n", "<leader>$", function()
    vim.cmd('lua StringToLiteral()')
end)

