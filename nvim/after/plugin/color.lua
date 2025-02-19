function Color(color)
  color = color or "duskfox"
  vim.cmd.colorscheme(color)
  vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
  highlight StatusLine guibg=NONE ctermbg=NONE
  highlight StatusLineNC guibg=NONE ctermbg=NONE
  highlight TabLine guibg=NONE ctermbg=NONE
  highlight TabLineFill guibg=NONE ctermbg=NONE
  highlight TabLineSel guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight CursorLineNr guibg=NONE ctermbg=NONE
  highlight FoldColumn guibg=NONE ctermbg=NONE
  " highlight Pmenu guibg=NONE ctermbg=NONE
  " highlight PmenuSel guibg=NONE ctermbg=NONE
  " highlight PmenuSbar guibg=NONE ctermbg=NONE
  highlight PmenuThumb guibg=NONE ctermbg=NONE
  highlight VisualNOS guibg=NONE ctermbg=NONE
  highlight NeoTreeNormal guibg=NONE ctermbg=NONE
  highlight NeoTreeNormalNC guibg=NONE ctermbg=NONE
  ]])
end
vim.g.moonflyWinSeparator = 0

Color()

