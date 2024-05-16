
-- :map output to buffer
vim.api.nvim_create_user_command('Map',function()
    vim.cmd('redir @" | silent map | redir END | new | put!')
end,{})

-- update config
vim.api.nvim_create_user_command('So',function()
    vim.cmd(':so ~/.config/nvim/init.lua')
end,{})
