local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp.preset("recommended")

-- lspconfig.tailwindcss.setup({
--   settings = {
--     tailwindCSS = {
--       classAttributes = { "className", ".*ClassName", "clsx" },
--       classFunctions = { "clsx", "tw" },
--       emmetCompletions = true,
--       experimental = {
--         classRegex = {
--           { "clsx\\(([^)]*)\\)", 1 },
--         },
--       },
--     },
--   },
-- })

lsp.nvim_workspace()
--
lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I',
  },
})
--
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gr", function() vim.cmd("Telescope lsp_references") end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>ee", function() vim.diagnostic.setqflist() end, opts)
  vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
--
lsp.setup()
--
vim.diagnostic.config({
  virtual_text = false,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

-- vim.api.nvim_create_user_command('WorkspaceDiagnostics', function()
--   vim.diagnostic.setqflist()
-- end, {})

vim.api.nvim_create_user_command("ToggleVirtualText", function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not current })
end, {})
