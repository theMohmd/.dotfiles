-- ASCII Table Generator for Neovim
-- Usage: generate_table(rows, cols, cell_width)

local function generate_table(rows, cols, cell_width)
  cell_width = cell_width or 10

  local lines = {}

  -- Generate horizontal line with appropriate connectors
  local function make_horizontal_line(is_top, is_bottom, is_middle)
    local line = ""

    for col = 1, cols do
      if col == 1 then
        if is_top then
          line = line .. "┌"
        elseif is_bottom then
          line = line .. "└"
        else
          line = line .. "├"
        end
      else
        if is_top then
          line = line .. "┬"
        elseif is_bottom then
          line = line .. "┴"
        else
          line = line .. "┼"
        end
      end

      -- Add horizontal line
      line = line .. string.rep("─", cell_width)
    end

    -- Add right border
    if is_top then
      line = line .. "┐"
    elseif is_bottom then
      line = line .. "┘"
    else
      line = line .. "┤"
    end

    return line
  end

  -- Generate content row
  local function make_content_row()
    local line = ""
    for col = 1, cols do
      line = line .. "│" .. string.rep(" ", cell_width)
    end
    line = line .. "│"
    return line
  end

  -- Generate the table
  for row = 1, rows do
    -- Add horizontal separator
    if row == 1 then
      table.insert(lines, make_horizontal_line(true, false, false))
    else
      table.insert(lines, make_horizontal_line(false, false, true))
    end

    -- Add content row
    table.insert(lines, make_content_row())
  end

  -- Add bottom border
  table.insert(lines, make_horizontal_line(false, true, false))

  return lines
end

-- Function to insert table at cursor position
local function insert_table_at_cursor(rows, cols, cell_width)
  local table_lines = generate_table(rows, cols, cell_width)
  local current_line = vim.api.nvim_win_get_cursor(0)[1]

  vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, false, table_lines)
end

-- Create user command
vim.api.nvim_create_user_command('GenTable', function(opts)
  local args = vim.split(opts.args, ' ')
  local rows = tonumber(args[1]) or 6
  local cols = tonumber(args[2]) or 2
  local cell_width = tonumber(args[3]) or 10

  insert_table_at_cursor(rows, cols, cell_width)
end, {
nargs = '*',
desc = 'Generate ASCII table (rows cols cell_width)'
})

-- Alternative: bind to a key mapping
-- vim.keymap.set('n', '<leader>gt', function()
  --     insert_table_at_cursor(6, 4, 30)
  -- end, { desc = 'Generate table' })

  return {
    generate_table = generate_table,
    insert_table_at_cursor = insert_table_at_cursor
  }
