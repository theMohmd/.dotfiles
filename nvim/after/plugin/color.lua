function Color(color)
    color = color or "duskfox"
    vim.cmd.colorscheme(color)
    --vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
end
vim.g.moonflyWinSeparator = 0

Color()

