local builtin = require('telescope.builtin')
local utils = require('telescope.utils')
vim.keymap.set('n', '<leader>g', function()
    builtin.grep_string({search = vim.fn.input("Grep > ")})
end)
vim.keymap.set('n', '<leader>/', function()
    builtin.grep_string({cwd = utils.buffer_dir(), search = vim.fn.input("Grep > ")})
end)

-- Function to check if the current directory is a Git repository
local function conditional_telescope()
  local result = vim.fn.system('git rev-parse --is-inside-work-tree 2>/dev/null')
  local temp = vim.v.shell_error == 0 and result == 'true\n'
  if temp then
      print("Current project is a Git repository!")
      builtin.git_files()
  else
      print("Current project is not a Git repository.")
      builtin.find_files()
  end
end

vim.keymap.set('n', '<leader>f', conditional_telescope, {})
