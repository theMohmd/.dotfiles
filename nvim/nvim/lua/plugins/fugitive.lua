return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set("n", "<leader>G", function()
      vim.cmd("Git")
      vim.cmd("winc L")
      vim.cmd("vertical resize 80")
    end)
  end,
}
