local M = {}
-- Function to pass visually selected text to another function
function M.get_selected_text()
  -- Get the start and end positions of the visual selection
  -- [bufnum, lnum, col, off]
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Extract the selected text line by line
  local selected_text = {}
  -- print("s r",start_pos[2])
  -- print("s c",start_pos[3])
  -- print("e r",end_pos[2])
  -- print("e c",end_pos[3])

  for i = start_pos[2], end_pos[2] do
    local line = vim.fn.getline(i)

    -- If it's only one line
    -- if start_pos[2] == end_pos[2] then
    --   line = string.sub(line, start_pos[3], end_pos[3])
    -- end

      -- If it's the first line, slice from the start column
    if i == start_pos[2] then
      line = string.sub(line, start_pos[3])
    end

    -- If it's the last line, slice up to the end column
    if i == end_pos[2] then
      if start_pos[2] == end_pos[2] then
        line = string.sub(line, 1, end_pos[3] - start_pos[3] + 1)
      else
        line = string.sub(line, 1, end_pos[3])
      end
    end

    table.insert(selected_text, line)
  end

  -- Join the lines into a single string
  local selected_text_str = table.concat(selected_text, " ")

  -- Call your custom function with the selected text
  return selected_text_str
end

function M.replace_selected_text(result)
 -- Get the start and end positions of the selected area
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Get the lines where the selection starts and ends
  local start_row, start_col = start_pos[2], start_pos[3]
  local end_row, end_col = end_pos[2], end_pos[3]

  -- Get the line where the selection starts and ends
  local start_line = vim.fn.getline(start_row)
  local end_line = vim.fn.getline(end_row)

  -- If the selection is within the same line
  if start_row == end_row then
    -- Replace the selected part of the line
    local new_line = start_line:sub(1, start_col - 1) .. result .. start_line:sub(end_col + 1)
    vim.api.nvim_buf_set_lines(0, start_row - 1, start_row, false, {new_line})
  else
    -- Replace the first line from start_col to the end
    local new_start_line = start_line:sub(1, start_col - 1) .. result
    vim.api.nvim_buf_set_lines(0, start_row - 1, start_row, false, {new_start_line})

    -- Clear the middle lines
    for i = start_row + 1, end_row - 1 do
      vim.api.nvim_buf_set_lines(0, i - 1, i, false, {""})
    end

    -- Replace the last line up to end_col
    local new_end_line = end_line:sub(end_col + 1)
    vim.api.nvim_buf_set_lines(0, end_row - 1, end_row, false, {new_end_line})
  end
end

return M
