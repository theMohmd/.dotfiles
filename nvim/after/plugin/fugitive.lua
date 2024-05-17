vim.keymap.set("n", "<leader>G", function()
    vim.cmd("Git")
    vim.cmd("horizontal resize 12")
    vim.cmd("winc J")
end)

