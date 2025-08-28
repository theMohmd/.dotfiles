local harpoon = require("harpoon")

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

harpoon.setup({
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
  },
  menu = {
    width = 120,
    height = 20,
  },
})

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu)
