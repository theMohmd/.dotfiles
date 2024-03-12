function Color(color)
    color = color or "github_dark_tritanopia"
    vim.cmd.colorscheme(color)
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
end

Color()

