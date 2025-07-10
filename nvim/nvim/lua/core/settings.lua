-- Cursor appearance (empty disables GUI cursor styles)
vim.opt.guicursor = ""

-- Line numbers
vim.opt.nu = true                                    -- Show absolute line numbers
vim.opt.relativenumber = true                        -- Show relative line numbers

-- Tabs and indentation
vim.opt.tabstop = 2                                  -- Number of spaces a <Tab> counts for
vim.opt.softtabstop = 2                              -- Number of spaces for editing operations
vim.opt.shiftwidth = 2                               -- Number of spaces for each indentation
vim.opt.expandtab = true                             -- Convert tabs to spaces
vim.opt.smartindent = true                           -- Smart auto-indenting

-- Wrapping
vim.opt.wrap = false                                 -- Disable line wrapping

-- Swap/Backup/Undo
vim.opt.swapfile = false                             -- Disable swap file
vim.opt.backup = false                               -- Disable backup file
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo" -- Directory for undo files
vim.opt.undofile = true                              -- Enable persistent undo

-- Search
vim.opt.hlsearch = false                             -- Don't highlight search matches
vim.opt.incsearch = true                             -- Show search matches as you type

-- UI
vim.opt.termguicolors = true                         -- Enable true color support
vim.opt.scrolloff = 8                                -- Keep 8 lines visible when scrolling
vim.opt.signcolumn = "yes"                           -- Always show the sign column
vim.opt.isfname:append("@-@")                        -- Allow `@` in filenames

vim.opt.updatetime = 50                              -- Faster update time for things like CursorHold

-- Case-insensitive search
vim.opt.ignorecase = true

-- Whitespace characters
vim.opt.list = true
vim.opt.listchars = {
  multispace = ' .',                                 -- Show dots for multiple spaces
  trail = '~',                                       -- Show ~ for trailing spaces
  extends = '>',                                     -- Show > at line end overflow
  precedes = '<',                                    -- Show < at line start overflow
  tab = '<>'                                         -- Show <> for tabs
}

-- NetRW file explorer
vim.g.netrw_banner = 0                               -- Disable netrw banner

-- Neoformat (Prettier)
vim.g.neoformat_try_node_exe = 1                     -- Prefer local Node executable
vim.g.neoformat_enabled_javascript = { 'prettier' }
vim.g.neoformat_enabled_typescript = { 'prettier' }
vim.g.neoformat_enabled_html = { 'prettier' }
vim.g.neoformat_enabled_css = { 'prettier' }
vim.g.neoformat_enabled_json = { 'prettier' }
-- vim.g.neoformat_run_all_formatters = 1            -- (Optional) run all configured formatters

-- Bidirectional text (useful for RTL languages)
vim.opt.termbidi = true

-- Folding
vim.o.foldmethod = "indent"                          -- Use indentation for fold logic
vim.o.foldlevelstart = 99                            -- Open all folds by default
vim.o.foldenable = true                              -- Enable code folding

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
