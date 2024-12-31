-- Enable Prettier for specific file types including tsx and jsx
vim.g.neoformat_enabled_prettier = {
  'javascript', 'typescript', 'json', 'css', 'html', 'typescriptreact', 'javascriptreact'
}

-- Optionally, set the Prettier executable (local or global)
vim.g.neoformat_prettier = {
  exe = 'npx',
  args = { 'prettier', '--write', '--no-semi', vim.fn.expand('%') },
  stdin = false,
}
