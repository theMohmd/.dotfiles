vim.keymap.set("n", "<leader>G", function()
    vim.cmd("Git")
    --vim.cmd("horizontal resize 12")
    vim.cmd("winc L")
    vim.cmd("vertical resize 80")
end)


-- vim.keymap.set("n", "<leader>GG", ":LazyGit<CR>", { desc = "Open LazyGit" })
