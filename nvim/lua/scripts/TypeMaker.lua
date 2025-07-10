local utils = require("scripts.utils")

local function type_maker(ts)
  -- Extract the main type name from the input
  local main_type_name = ts:match("export type T(%w+)")
  if not main_type_name then
    return "Error: Could not extract type name"
  end
  
  local const_arrays = {}
  local nested_types = {}
  local main_properties = {}
  
  local function capitalize_first(str)
    return str:gsub("^%l", string.upper)
  end
  
  local function parse_key_value(k, v, type_prefix)
    -- Remove trailing semicolon and whitespace
    v = v:gsub(";$", ""):gsub("%s+$", "")
    
    if v == "true" or v == "false" then
      return k .. ": boolean;"
    elseif v:match('^"%d%d%d%d%-%d%d%-%d%dT') then
      return k .. ": string; //iso date string"
    elseif v:match('^"[^"]*"$') and v ~= '"string"' then
      -- This is a string literal (not the generic "string"), create const array and type
      local literal_value = v:match('^"(.+)"$')
      local const_name = string.lower(type_prefix) .. capitalize_first(k) .. "s"
      local type_name = "T" .. type_prefix .. capitalize_first(k)
      
      table.insert(const_arrays, string.format("export const %s = [] as const;", const_name))
      table.insert(const_arrays, string.format("export type %s = (typeof %s)[number];", type_name, const_name))
      
      return k .. ": " .. type_name .. ";"
    elseif v == '"string"' then
      return k .. ": string;"
    elseif v:match('^%d+$') then
      return k .. ": number;"
    elseif v:match('^%s*{') then
      -- This is a nested object, create a type for it
      local type_name = "T" .. type_prefix .. capitalize_first(k)
      table.insert(nested_types, string.format("export type %s = {};", type_name))
      return k .. ": " .. type_name .. ";"
    else
      return k .. ": " .. v .. ";"
    end
  end
  
  -- Split input into lines and process
  local lines = {}
  for line in ts:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end
  
  -- Find the start of the type definition
  local start_idx = nil
  for i, line in ipairs(lines) do
    if line:match("export type T" .. main_type_name) then
      start_idx = i
      break
    end
  end
  
  if not start_idx then
    return "Error: Could not find type definition"
  end
  
  -- Process lines starting from the type definition
  local brace_count = 0
  local found_opening_brace = false
  
  for i = start_idx, #lines do
    local line = lines[i]:gsub("^%s+", ""):gsub("%s+$", "") -- trim
    
    -- Count braces
    for char in line:gmatch(".") do
      if char == "{" then
        brace_count = brace_count + 1
        found_opening_brace = true
      elseif char == "}" then
        brace_count = brace_count - 1
      end
    end
    
    -- If we've found the opening brace, start processing properties
    if found_opening_brace and brace_count > 0 then
      -- Extract key-value pairs from this line
      local key, value = line:match("^([%w_]+)%s*:%s*(.+)")
      if key and value then
        local property = parse_key_value(key, value, main_type_name)
        table.insert(main_properties, "\t" .. property)
      end
    end
    
    -- Stop when we've closed all braces
    if found_opening_brace and brace_count == 0 then
      break
    end
  end
  
  -- Build the final output
  local output = {}
  
  -- Add const arrays and their types
  for _, const_line in ipairs(const_arrays) do
    table.insert(output, const_line)
  end
  
  -- Add nested types
  for _, nested_type in ipairs(nested_types) do
    table.insert(output, nested_type)
  end
  
  -- Add main type
  table.insert(output, string.format("export type T%s = {", main_type_name))
  for _, prop in ipairs(main_properties) do
    table.insert(output, prop)
  end
  table.insert(output, "};")
  
  return table.concat(output, "\n")
end

-- Wrapper function to handle selected text in Neovim
local function type_maker_wrapper()
  local selected_text = utils.get_selected_text()
  -- If no selection, do nothing
  if selected_text == "" then
    print("No text selected.")
    return
  end
  -- Generate the property string
  local result = type_maker(selected_text)
  -- Put the result in a register
  vim.fn.setreg('a', result)
  -- Replace the selected text with the result using the 'a' register
  vim.cmd('normal! gv"ap')
end

-- Create the user command in Neovim
vim.api.nvim_create_user_command("Typemaker", type_maker_wrapper, {range = true})
