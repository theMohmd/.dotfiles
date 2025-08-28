local telescope = require('telescope')

telescope.setup({
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>g', function()
  --     builtin.grep_string({search = vim.fn.input("Grep > ")})
  --   end)
  vim.keymap.set('n', '<leader>g', function()
    builtin.live_grep({use_regex=true})

  end, {})
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
  vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})
  vim.keymap.set('n', '<leader>F', function()
    require('telescope.builtin').find_files({
      hidden = true,
      no_ignore = true,
      no_ignore_parent = true
    })
  end, {})
  -- vim.keymap.set('n', '<leader>F', conditional_telescope, {})
  vim.keymap.set('n', '<leader>f', function() builtin.find_files({
  file_ignore_patterns = { "^%.git/" },
 shorten_path = true,
}) end, {})
