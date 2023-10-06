function Color(color)
	color = color or "github_dark_dimmed"
	vim.cmd.colorscheme(color)
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
end

Color()
