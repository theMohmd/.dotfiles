function Color(color)
    color = color or "material-deep-ocean"
    vim.cmd.colorscheme(color)
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
end

Color()

