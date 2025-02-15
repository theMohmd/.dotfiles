-- Disable default <Tab> mapping for Copilot
-- vim.g.copilot_no_tab_map = true

-- Map <C-l> to accept Copilot suggestion
vim.api.nvim_set_keymap('i', '<M-p>', 'copilot#Accept("<CR>")', { expr=true, noremap = true, silent = true })
vim.g.copilot_no_tab_map = true
-- Map <C-j> and <C-k> to cycle through suggestions
vim.keymap.set("i", "<M-n>", "<Plug>(copilot-next)", { silent = true })
-- vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { silent = true })
