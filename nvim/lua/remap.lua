vim.g.mapleader = " "

--keymap cheat sheet
vim.keymap.set("n", "<leader>0", function()
    while (vim.fn.winnr() ~= 1) do
        vim.cmd('wincmd h')
    end
    if (vim.fn.bufname() == '/home/mads/myNvimCheatSheat.txt') then
        vim.cmd('close')
        return
    end
    vim.cmd('50 vsplit')
    vim.cmd('e ~/myNvimCheatSheat.txt')
end)

vim.keymap.set("n", "<leader>L", function()
    vim.cmd('tabnew')
    vim.cmd('e ~/.config/nvim')
end)

--normal mode enter
vim.keymap.set("n", "<leader><cr>", [[i<cr><esc>]])

--sudawrite
vim.keymap.set("n", "<leader>W", function() vim.cmd('SudaWrite') end)

--clipboard
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["+d]])

--deletion: default void delete
--vim.keymap.set({"n", "v"}, "D" ,[[d]])
--vim.keymap.set({"n", "v"}, "d" ,[["_d]])
--vim.keymap.set({"n"}, "x" ,[["_x]])

--previous buffer
vim.keymap.set("n", "<leader>b", "<c-^>")

--duplicate line
vim.keymap.set("n", "<leader>a", "yyp")

--file explorer
--vim.keymap.set("n", "<leader>e", function() vim.cmd('e .') end)

--undo redo
vim.keymap.set("n", "U", "<c-r>")

--quit
vim.keymap.set("n", "<leader>q", vim.cmd.q)

--new line noraml mode
vim.keymap.set("n", "<leader>o", "o<esc>")
vim.keymap.set("n", "<leader>O", "O<esc>")


--replace word
vim.keymap.set("n", "<leader>s", [[:%s//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>sa", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
vim.keymap.set("n", "<leader>sl", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

--save
vim.keymap.set("n", "<leader><leader>", vim.cmd.w)
-- vim.keymap.set("n", "<leader><leader>", function()
--   -- vim.lsp.buf.format()  -- Format the buffer
--   vim.cmd("w")          -- Save the file
-- end )


--prettier and tailwind
-- vim.keymap.set("n", "<leader>;", vim.cmd("!npx prettier --write %"))


-- vim.keymap.set('n', '<leader>;', function()
--   vim.cmd('w')
--   vim.fn.jobstart('npx prettier --write ' .. vim.fn.expand('%'), {
--     stdout_buffered = true,
--     stderr_buffered = true,
--     on_exit = function(_, code)
--       if code == 0 then
--         print('Prettier: Format successful!')
--         vim.cmd('e')  -- Reload the file after successful formatting
--       else
--         print('Prettier: Format failed!')
--       end
--     end
--   })
-- end, { noremap = true, silent = true })

-- vim.keymap.set("n", "<leader>;", function()
--     --vim.cmd('w')
--     --vim.cmd('PrettierAsync')
--     vim.cmd('Neoformat')
--     vim.cmd('w')
-- end)
vim.keymap.set("n", "<leader>:", function()
    --vim.cmd('w')
    -- vim.cmd('PrettierAsync')
    vim.cmd('Neoformat')
    vim.cmd('w')
end)

-- vim.keymap.set("n", "<leader>:", [[:w<cr>:silent !rustywind --write %<cr>]])

--move in insert mode
vim.keymap.set("i", "<A-l>", "<C-o>l")
vim.keymap.set("i", "<A-j>", "<C-o>j")
vim.keymap.set("i", "<A-k>", "<C-o>k")
vim.keymap.set("i", "<A-h>", "<C-o>h")

--center page up / down / next / prev
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--better end of line
vim.keymap.set("n", ")", "$")
vim.keymap.set("v", ")", "$")

--visual move line
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

--append line below to this line
vim.keymap.set("n", "J", "mzJ`z")

--quick fix
vim.keymap.set("n", "<leader>l", vim.cmd.cc)
vim.keymap.set("n", "<leader>ll", vim.cmd.cn)
vim.keymap.set("n", "<leader>lp", vim.cmd.cp)
vim.keymap.set("n", "<leader>lo", vim.cmd.copen)
vim.keymap.set("n", "<leader>lc", vim.cmd.cclose)

-- --tab
-- vim.keymap.set("n", "<leader>tc", vim.cmd.tabc)
-- vim.keymap.set("n", "<leader>tn", vim.cmd.tabn)
-- vim.keymap.set("n", "<leader>tp", vim.cmd.tabp)

--comment jsx
--vim.keymap.set("n", "<leader>c", "I{/<esc>78a*<esc>a<cr><esc>o*<esc>77i*<esc>ea/}<esc>")
vim.keymap.set("n", "<leader>cl", "I{/*<esc>77a*<esc>a<cr>  <esc>A */}<esc>")
vim.keymap.set("n", "<leader>cm", "I{/* <esc>A */}<esc>")
vim.keymap.set("n", "<leader>cd", "?{\\/\\*<cr>df:/\\*\\/}<cr>5x")
vim.keymap.set("n", "<leader>cc", "I{/* TODO : <esc>A *<esc>a/}<esc>")
vim.keymap.set("v", "<leader>cc", "<c-v><s-v>\"ddO{/* TODO :<esc>o*/}<esc>\"dP")

--fix width
vim.keymap.set("n", "<leader>w", function()
  local size = vim.v.count -- Get the number before <leader>w
  if size > 0 then
    vim.cmd("vertical resize " .. size)
  else
    vim.cmd("vertical resize 40") -- Default width if no number is provided
  end
end, { silent = true })

--run bash
vim.keymap.set("n", "<leader>r",function()
  vim.cmd('!echo \"loading...\">res.json && bash % > res.json')
end)

vim.keymap.set("n", "<leader>e",function()
  vim.cmd('cexpr system("tsc --noEmit")')
  vim.cmd('copen')
end)

vim.keymap.set("v", "x", "<esc>ggVG")
