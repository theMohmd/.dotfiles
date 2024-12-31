-- Use Telescope to find and open files
vim.api.nvim_create_user_command('OpenAllFiles', function()
  require('telescope.builtin').find_files({ search_dirs = { "." } })
end, {})

vim.api.nvim_create_user_command('RefreshWorkspaceDiagnostics', function()
  vim.lsp.buf.workspace_diagnostic_refresh()
end, {})
