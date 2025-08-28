-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError",
{text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn",
{text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo",
{text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint",
{text = "󰌵", texthl = "DiagnosticSignHint"})


local Path = require("plenary.path")
local builtin = require("telescope.builtin")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

local function copy_file_from_other_project_to_dir(target_dir)
  builtin.find_files({
    prompt_title = "Copy file from other project",
    cwd = "/home/mads/code/main",
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        local file_path = entry.path
        local filename = file_path:match("^.+/(.+)$")
        local dest_path = Path:new(target_dir, filename)

        -- Create target directory if needed
        dest_path:parent():mkdir({ parents = true })

        -- Copy file
        Path:new(file_path):copy({ destination = dest_path })

        vim.notify("Copied to " .. dest_path:absolute(), vim.log.levels.INFO)
        actions.close(prompt_bufnr)
      end)
      return true
    end,
  })
end

require("neo-tree").setup({
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  enable_git_status = true,
  diagnostic = {enable=true,auto_open=true},
  window = {
    position = "left",
    mappings = {
      ['z'] = 'close_all_subnodes',
      ['/'] = '',
      ['?'] = 'filter_as_you_type',
      ["gu"] = "git_unstage_file",    -- Unstage the selected file
      ["ga"] = "git_add_file",        -- Stage the selected file
      ["gr"] = "git_revert_file",     -- Revert changes in the file

      ["A"] = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" then
          copy_file_from_other_project_to_dir(node.path)
        else
          vim.notify("Not a directory", vim.log.levels.WARN)
        end
      end,
    }
  },
  filesystem = {
    filtered_items = {
      always_show = { -- remains visible even if other settings would normally hide it
        ".gitignored",
      },
    },
  },
  git_status = {
    window = {
      position = "left",
      mappings = {
        ["A"]  = "git_add_all",         -- Stage all files
        ["gu"] = "git_unstage_file",    -- Unstage the selected file
        ["ga"] = "git_add_file",        -- Stage the selected file
        ["gr"] = "git_revert_file",     -- Revert changes in the file
        ["gc"] = "git_commit",          -- Commit changes
        ["gp"] = "git_push",            -- Push changes
        ["gg"] = "git_commit_and_push", -- Commit and push changes
      }
    }
  }
})

vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
vim.cmd([[nnoremap \\ :Neotree reveal<cr>]])
vim.cmd([[nnoremap \g :Neotree right git_status<cr>]])
