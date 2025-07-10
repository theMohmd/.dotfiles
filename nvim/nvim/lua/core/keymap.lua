vim.g.mapleader = " "

------------------------------------------------------------
-- General Utilities
------------------------------------------------------------

-- Open note.md in vertical split or close if already open
vim.keymap.set("n", "<leader>0", function()
  local note_path = "/home/mads/note.md"
  while (vim.fn.winnr() ~= 1) do vim.cmd('wincmd h') end
  if vim.fn.bufname() == note_path then
    vim.cmd('close')
  else
    vim.cmd('100 vsplit')
    vim.cmd('e ' .. note_path)
  end
end)

-- Open config folder in a new tab
vim.keymap.set("n", "<leader>L", function()
  vim.cmd('tabnew')
  vim.cmd('e ~/.config/nvim')
end)

-- Insert newline from normal mode
vim.keymap.set("n", "<leader><cr>", [[i<cr><esc>]])

-- Save with sudo
vim.keymap.set("n", "<leader>W", function() vim.cmd('SudaWrite') end)

-- Save file
vim.keymap.set("n", "<leader><leader>", vim.cmd.w)

-- Quit
vim.keymap.set("n", "<leader>q", vim.cmd.q)

------------------------------------------------------------
-- Clipboard Helpers
------------------------------------------------------------

-- Helper to reduce repetition
local function clipboard_map(mode, lhs, reg)
  vim.keymap.set(mode, "<leader>" .. lhs, [["]] .. reg)
end

clipboard_map({ "n", "v" }, "y", "+y")
clipboard_map({ "n", "v" }, "Y", "+Y")
clipboard_map({ "n", "v" }, "p", "+p")
clipboard_map({ "n", "v" }, "P", "+P")
clipboard_map({ "n", "v" }, "d", "+d")

------------------------------------------------------------
-- Editing
------------------------------------------------------------

-- Replace word
vim.keymap.set("n", "<leader>s", [[:%s//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>sa", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
vim.keymap.set("n", "<leader>sl", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

-- Duplicate line
vim.keymap.set("n", "<leader>a", "yyp")

-- New line (keep in normal mode)
vim.keymap.set("n", "<leader>o", "o<esc>")
vim.keymap.set("n", "<leader>O", "O<esc>")

-- Undo/Redo
vim.keymap.set("n", "U", "<c-r>")

-- Replace current buffer with previous
vim.keymap.set("n", "<leader>b", "<c-^>")

-- Append next line to current
vim.keymap.set("n", "J", "mzJ`z")

-- End of line shortcut
vim.keymap.set("n", ")", "$")
vim.keymap.set("v", ")", "$")

-- Center search navigation
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Scroll with centering
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

------------------------------------------------------------
-- Visual Mode Utilities
------------------------------------------------------------

-- Move selected lines
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Select all
vim.keymap.set("n", "<leader>A", "ggVG")

------------------------------------------------------------
-- Insert Mode Navigation
------------------------------------------------------------

vim.keymap.set("i", "<A-l>", "<C-o>l")
vim.keymap.set("i", "<A-j>", "<C-o>j")
vim.keymap.set("i", "<A-k>", "<C-o>k")
vim.keymap.set("i", "<A-h>", "<C-o>h")

------------------------------------------------------------
-- Formatting
------------------------------------------------------------

vim.keymap.set("n", "<leader>;", function()
  vim.cmd('Neoformat')
  vim.cmd('w')
end)

------------------------------------------------------------
-- Comment Helpers (JSX-style)
------------------------------------------------------------

vim.keymap.set("n", "<leader>cl", "I{/*<esc>77a*<esc>a<cr>  <esc>A */}<esc>")
vim.keymap.set("n", "<leader>cm", "I{/* <esc>A */}<esc>")
vim.keymap.set("n", "<leader>cd", "?{\\/\\*<cr>df:/\\*\\/}<cr>5x")
vim.keymap.set("n", "<leader>cc", "I{/* TODO : <esc>A *<esc>a/}<esc>")
vim.keymap.set("v", "<leader>cc", "<c-v><s-v>\"ddO{/* TODO :<esc>o*/}<esc>\"dP")

------------------------------------------------------------
-- Tabs and Windows
------------------------------------------------------------

-- Close tab
vim.keymap.set("n", "<leader>tc", vim.cmd.tabc)

-- Fix vertical split width
vim.keymap.set("n", "<leader>w", function()
  local size = vim.v.count
  if size > 0 then
    vim.cmd("vertical resize " .. size)
  else
    vim.cmd("vertical resize 40")
  end
end, { silent = true })

------------------------------------------------------------
-- Quickfix
------------------------------------------------------------

vim.keymap.set("n", "<leader>l", vim.cmd.cc)
vim.keymap.set("n", "<leader>ll", vim.cmd.cn)
vim.keymap.set("n", "<leader>lp", vim.cmd.cp)
vim.keymap.set("n", "<leader>lo", vim.cmd.copen)
vim.keymap.set("n", "<leader>lc", vim.cmd.cclose)

------------------------------------------------------------
-- Run Commands
------------------------------------------------------------

-- Run current bash script and dump result to file
vim.keymap.set("n", "<leader>r", function()
  vim.cmd('!echo "loading..." > res.json && bash % > res.json')
end)

-- Run TypeScript type check in quickfix
vim.keymap.set("n", "<leader>e", function()
  vim.cmd('cexpr system("tsc --noEmit")')
  vim.cmd('copen')
end)
