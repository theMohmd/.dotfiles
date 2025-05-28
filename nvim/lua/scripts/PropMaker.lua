local utils = require("scripts.utils")

-- Extract variables from the input string
local function extract_vars(vars_str)
  local vars = {}
  for var in vars_str:gmatch("(%w+)") do
    table.insert(vars, var)
  end
  return vars
end

-- Skip nested braces in a string
local function skip_nested_braces(str, i)
  local stack = 1
  i = i + 1

  while i <= #str do
    local char = str:sub(i, i)
    if char == "{" then
      stack = stack + 1
    elseif char == "}" then
      stack = stack - 1
      if stack == 0 then
        return i
      end
    end
    i = i + 1
  end

  return i
end

-- Extract types from the input string
local function extract_types(types_str)
  local types = {}
  local i = 1
  local len = #types_str

  while i <= len do
    local key_start = i
    while i <= len and types_str:sub(i, i) ~= ":" do
      i = i + 1
    end
    if i > len then break end
    local key = types_str:sub(key_start, i - 1):match("^%s*(.-)%s*$")
    i = i + 1

    local type_start = i
    while i <= len do
      local char = types_str:sub(i, i)
      if char == "{" then
        i = skip_nested_braces(types_str, i)
      elseif char == ";" then
        break
      end
      i = i + 1
    end

    local type_value = types_str:sub(type_start, i - 1):match("^%s*(.-)%s*$")
    types[key] = type_value

    if types_str:sub(i, i) == ";" then
      i = i + 1
    end
  end

  return types
end

-- Main function to generate the property string
local function propMaker(input)
  -- Separate input into vars and types
  local vars_str = input:match("{(.-)}")
  local types_str = input:match("}:%s*{(.*)}%s*$") or ""

  -- Return input if format is invalid
  if not vars_str then return input end

  local vars = extract_vars(vars_str)
  local types = extract_types(types_str)

  -- Add missing vars with "string" type
  for _, var in ipairs(vars) do
    if not types[var] then
      types[var] = "string"
    end
  end

  -- Format output
  local formatted_vars = "  " .. table.concat(vars, ",\n  ")
  local type_parts = {}
  for key, value in pairs(types) do
    table.insert(type_parts, "  " .. key .. ": " .. value .. ";")
  end
  local formatted_types = table.concat(type_parts, "\n")

  return "{\n" .. formatted_vars .. "\n}: {\n" .. formatted_types .. "\n}"
end

-- Wrapper function to handle selected text in Neovim
local function propMakerWrapper()
  local selected_text = utils.get_selected_text()

  -- If no selection, do nothing
  if selected_text == "" then
    print("No text selected.")
    return
  end

  -- Generate the property string
  local result = propMaker(selected_text)

  -- Put the result in a register
  vim.fn.setreg('a', result)

  -- Replace the selected text with the result using the 'a' register
  vim.cmd('normal! gv"ap')
end

-- Create the user command in Neovim
vim.api.nvim_create_user_command("PropMaker", propMakerWrapper, {range = true})
