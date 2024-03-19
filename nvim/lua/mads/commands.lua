function StringToLiteral()
    vim.cmd([[normal! Ea ${} ]])
    vim.cmd([[normal! 0f"s{`]])
    vim.cmd([[normal! $F"s`}]])
    vim.cmd([[normal! 0f$2l]])
    vim.cmd('startinsert')
end

vim.keymap.set("n", "<leader>$", function()
    vim.cmd('lua StringToLiteral()')
end)

-- :map output to buffer
vim.api.nvim_create_user_command('Map',function()
    vim.cmd('redir @" | silent map | redir END | new | put!')
end,{})
