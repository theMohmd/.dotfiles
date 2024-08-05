-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError",
{text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn",
{text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo",
{text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint",
{text = "󰌵", texthl = "DiagnosticSignHint"})

require("neo-tree").setup({
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  window = {
    position = "right",
    mappings = {
      ['z'] = 'close_all_subnodes',
      ['/'] = '',
    }
  },
  filesystem = {
    filtered_items = {
      always_show = { -- remains visible even if other settings would normally hide it
        ".gitignored",
      },
    },

  },
})

vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
