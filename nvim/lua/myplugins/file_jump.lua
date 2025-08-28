function jump_to_prev_file()
  local jumplist = vim.fn.getjumplist()
  local jumps = jumplist[1]
  local current_pos = jumplist[2]
  
  -- Get current filename
  local current_filename = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  
  -- Iterate back from current position until filename changes
  for i = current_pos - 1, 1, -1 do
    local jump = jumps[i]
    local filename = vim.api.nvim_buf_get_name(jump.bufnr)
    
    if filename ~= current_filename and filename ~= "" then
      -- Calculate how many steps back we need to go
      local steps_back = current_pos - i
      
      -- Execute Ctrl-O the required number of times
      for _ = 1, steps_back do
        vim.cmd('normal! \\<C-o>')
      end
      return
    end
  end
end

vim.keymap.set('n', '<leader>j', jump_to_prev_file, { desc = 'Jump to previous file' })
