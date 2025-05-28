local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'jsonls',
    'eslint',
    'tailwindcss',
    'emmet_language_server'
})

lsp.configure("tailwindcss", {
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "/.*ClassName$/" }, -- Enables suggestions for any variable ending in "ClassName"
      experimental = {
        classRegex = {
          { '([%w_]-ClassName)%s*=%s*"([^"]*)"', "class" }, -- For "headerClassName = 'text-red-500'"
          { '([%w_]-ClassName)%s*=%s*`([^`]*)`', "class" }, -- For `const headerClassName = `text-red-500``
        },
      },
    },
  },
})

-- Fix Undefined global 'vim'

lsp.nvim_workspace()
lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

--diagnostic check
-- local function refresh_diagnostics()
--   for _, client in pairs(vim.lsp.get_active_clients()) do
--     client.request("textDocument/publishDiagnostics", {})
--   end
-- end
lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gr", function() vim.cmd("Telescope lsp_references") end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ee", function() vim.diagnostic.get_all() end, opts)
    vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

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

vim.api.nvim_create_user_command('WorkspaceDiagnostics', function()
  vim.lsp.buf.workspace_diagnostic_refresh()
end, {})
