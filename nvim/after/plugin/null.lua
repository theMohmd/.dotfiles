local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
  },
  timeout = 10000,


  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then

      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   callback = function()
      --     vim.lsp.buf.format({ async = false })
      --   end,
      -- })

      vim.keymap.set("n", "<Leader>:", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        vim.cmd("w")
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end

})


-- local null_ls = require("null-ls")
-- local formatting = null_ls.builtins.formatting
--
-- null_ls.setup({
--   sources = {
--     formatting.prettier, -- Ensure Prettier is loaded
--     -- formatting.eslint_d, -- Optionally add ESLint
--   },
--   timeout = 100000,
--   on_attach = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--       vim.keymap.set("n", "<Leader>;", function()
--         vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
--         vim.cmd("w")
--       end, { buffer = bufnr, desc = "[lsp] format" })
--     end
--
--     if client.supports_method("textDocument/rangeFormatting") then
--       vim.keymap.set("x", "<Leader>;", function()
--         vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
--       end, { buffer = bufnr, desc = "[lsp] format" })
--     end
--   end,
-- })
