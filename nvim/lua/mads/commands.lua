function StringToLiteral()
    vim.cmd([[normal! "5di"xs{``}]])
    vim.cmd([[normal! h"5P]])
end
vim.cmd([[command! Sl lua StringToLiteral()]])
