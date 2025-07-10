local M = {}

function M.copy(args)
  return args[1]
end

function M.capitalize_first(str)
  return str:sub(1,1):upper() .. str:sub(2)
end

function M.lower_first(str)
  return str:sub(1,1):lower() .. str:sub(2)
end

function M.camel_to_kebab(str)
  return str:gsub("(%u)", function(letter)
    return "-" .. letter:lower()
  end)
end

function M.kebab_to_camel(str)
  return str:gsub("-(%a)", function(letter)
    return letter:upper()
  end):gsub("^(%a)", function(first)
    return first:lower()
  end)
end

function M.get_folder_name(n)
  n = n or 0
  local path = vim.fn.expand('%:p')
  local parts = {}
  for part in path:gmatch("[^/]+") do
    table.insert(parts, part)
  end
  return parts[#parts - 1 - n] or "Unknown"
end

function M.get_file_name()
  local full_path = vim.fn.expand('%:t')
  local name_without_extension = full_path:gsub("%..+$", "")
  return name_without_extension
end

return M
