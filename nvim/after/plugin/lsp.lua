local lsp = require("lsp-zero")
lsp.preset("recommended")

-- Configure Tailwind CSS with custom settings
lsp.configure("tailwindcss", {
  settings = {
    tailwindCSS = {
      classAttributes = { "className", ".*ClassName", "clsx" },
      classFunctions = { "clsx", "tw" },
      emmetCompletions = true,
      experimental = {
        classRegex = {
          { "clsx\\(([^)]*)\\)", 1 },
        },
      },
    },
  },
})

-- Prevent duplicate TypeScript server by skipping auto-setup
-- This ensures only one ts_ls instance runs
lsp.skip_server_setup({'ts_ls'})

-- Configure workspace settings
lsp.nvim_workspace()

-- Set LSP preferences
lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I',
  },
})

-- Set up key mappings for LSP functionality
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  
  -- Navigation
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gr", function() vim.cmd("Telescope lsp_references") end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  
  -- Diagnostics
  vim.keymap.set("n", "<leader>ee", function() vim.diagnostic.setqflist() end, opts)
  vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  
  -- Code actions and refactoring
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- Initialize lsp-zero
lsp.setup()

-- Manually configure TypeScript Language Server to prevent duplicates
require('lspconfig').ts_ls.setup({
  on_attach = lsp.build_options('ts_ls', {}).on_attach,
  capabilities = lsp.get_capabilities(),
  -- Add any custom TypeScript-specific settings here
  init_options = {
    hostInfo = "neovim"
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }
})

-- Enhanced diagnostic configuration
vim.diagnostic.config({
  virtual_text = false,
  float = {
    focusable = true,  -- Allow focusing diagnostic float
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    max_width = 80,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    }
  },
  underline = true,
  update_in_insert = false,  -- Don't show diagnostics while typing
  severity_sort = true,
})

-- Enhanced hover
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded",
    max_width = 80,
  }
)

-- Enhanced signature help
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "rounded",
    max_width = 80,
  }
)
-- Create user command to toggle virtual text diagnostics
vim.api.nvim_create_user_command("ToggleVirtualText", function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not current })
end, {})
