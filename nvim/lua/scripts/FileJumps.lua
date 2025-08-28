-- Function to extract unique files from :jumps output
function extract_unique_files_from_jumps(jumps_output)
  local files = {}
  local seen = {}

  -- Split input into lines
  for line in jumps_output:gmatch("[^\r\n]+") do
    -- Skip header or empty lines
    if line:match("^%s*%d+") then
      -- Extract the file path (4th column in :jumps output)
      local jump_num, line_num, col_num, filepath = line:match("^%s*(%d+)%s+(%d+)%s+(%d+)%s+(.+)$")

      if filepath then
        -- Normalize path: remove home directory prefix if present
        filepath = filepath:gsub("^~/[^/]+/[^/]+/[^/]+/", "")

        -- Add to unique files if not seen before
        if not seen[filepath] then
          seen[filepath] = true
          table.insert(files, {
            filename = filepath,
            lnum = tonumber(line_num),
            col = tonumber(col_num)
          })
        end
      end
    end
  end

  return files
end

-- Function to create location list from unique files
function create_location_list_from_jumps()
  -- Get jumps output
  local jumps_output = vim.fn.execute('jumps')

  -- Extract unique files
  local unique_files = extract_unique_files_from_jumps(jumps_output)

  -- Convert to location list format
  local location_list = {}
  for _, file_info in ipairs(unique_files) do
    table.insert(location_list, {
      filename = file_info.filename,
      lnum = file_info.lnum,
      col = file_info.col,
      text = "Jump location"
    })
  end

  -- Set the location list
  vim.fn.setloclist(0, location_list)

  -- Open location list window
  vim.cmd('lopen')

  return location_list
end

-- Neovim command to run the function
vim.api.nvim_create_user_command('JumpsToLocationList', function()
  create_location_list_from_jumps()
end, {})

