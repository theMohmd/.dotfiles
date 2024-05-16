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
--save
vim.keymap.set("n", "<leader><leader>", vim.cmd.w)

--normal mode enter
vim.keymap.set("n", "<cr>", [[i<cr><esc>]])

--sudawrite
vim.keymap.set("n", "<leader>W", function() vim.cmd('SudaWrite') end)

--clipboard
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["+d]])

--deletion
--vim.keymap.set({"n", "v"}, "D" ,[[d]])
--vim.keymap.set({"n", "v"}, "d" ,[["_d]])
--vim.keymap.set({"n"}, "x" ,[["_x]])

--previous buffer
vim.keymap.set("n", "<leader>b", "<c-^>")

--duplicate line
vim.keymap.set("n", "<leader>l", "yyp")

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

--prettier and tailwind
vim.keymap.set("n", "<leader>;", function()
    vim.cmd('w')
    vim.cmd('PrettierAsync')
end)
vim.keymap.set("n", "<leader>:", function()
    vim.cmd('w')
    vim.cmd("silent !rustywind --write %<cr>")
end)

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
--vim.keymap.set("n", "-", "$")

--dont ask
--vim.keymap.set("n", "Q", "<nop>")

--visual move line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--append line below to this line
vim.keymap.set("n", "J", "mzJ`z")

--quick fix
vim.keymap.set("n", "[[", vim.cmd.cn)
vim.keymap.set("n", "]]", vim.cmd.cp)
vim.keymap.set("n", "[]", vim.cmd.copen)
vim.keymap.set("n", "][", vim.cmd.cclose)

--tab
vim.keymap.set("n", "<leader>t", vim.cmd.tabn)


--comment
vim.keymap.set("n", "<leader>c", "I{/*<esc>A*/}<esc>")
--vim.keymap.set("i", "<c-d>", "<cr><c-o>k<c-o>$")

--impor
vim.keymap.set("n", "<leader>i", "ea<c-l><tab><esc>")

