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
  enable_git_status = true,
  diagnostic = {enable=true,auto_open=true},
  window = {
    position = "left",
    mappings = {
      ['z'] = 'close_all_subnodes',
      ['/'] = '',
      ['?'] = 'filter_as_you_type',
      ["gu"] = "git_unstage_file",    -- Unstage the selected file
      ["ga"] = "git_add_file",        -- Stage the selected file
      ["gr"] = "git_revert_file",     -- Revert changes in the file
    }
  },
  filesystem = {
    filtered_items = {
      always_show = { -- remains visible even if other settings would normally hide it
        ".gitignored",
      },
    },
  },
  git_status = {
    window = {
      position = "left",
      mappings = {
        ["A"]  = "git_add_all",         -- Stage all files
        ["gu"] = "git_unstage_file",    -- Unstage the selected file
        ["ga"] = "git_add_file",        -- Stage the selected file
        ["gr"] = "git_revert_file",     -- Revert changes in the file
        ["gc"] = "git_commit",          -- Commit changes
        ["gp"] = "git_push",            -- Push changes
        ["gg"] = "git_commit_and_push", -- Commit and push changes
      }
    }
  }
})

vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
vim.cmd([[nnoremap \\ :Neotree reveal<cr>]])
vim.cmd([[nnoremap \g :Neotree right git_status<cr>]])
