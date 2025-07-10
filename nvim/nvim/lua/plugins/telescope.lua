return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.8',
  dependencies = 'nvim-lua/plenary.nvim',
  build = ':!sudo pacman -S ripgrep',
  config = function()
    require('telescope').setup {
      pickers = {
        find_files = {
          hidden = true
        }
      }
    }

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
      vim.keymap.set('n', '<leader>F', conditional_telescope, {})
      vim.keymap.set('n', '<leader>f', function() builtin.find_files({
        file_ignore_patterns = { "^%.git/" }
      }) end, {})
    end
  }
