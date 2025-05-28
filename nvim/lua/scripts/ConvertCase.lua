local utils = require("scripts.utils")

-- Check if the string is in camelCase or kebab-case and convert
local function convertCase(str)
    -- Check if the string is in camelCase
    if str:match("^[a-z]+[A-Za-z0-9]*$") then
        -- Convert camelCase to kebab-case
        return str:gsub("([a-z])([A-Z])", "%1-%2"):lower()
    elseif str:match("^[a-z0-9%-]+$") then
        -- Convert kebab-case to camelCase
        return str:gsub("-%([a-z])", function(c) return c:upper() end)
    else
        return "Invalid input"
    end
end

-- Wrapper function to handle selected text in Neovim and convert it
local function convertCaseWrapper()
  local selected_text = utils.get_selected_text()

  -- If no selection, do nothing
  if selected_text == "" then
    print("No text selected.")
    return
  end

  -- Apply convertCase to the selected text
  local result = convertCase(selected_text)

  -- Put the result in a register
  vim.fn.setreg('a', result)

  -- Replace the selected text with the result using the 'a' register
  vim.cmd('normal! gv"ap')
end

-- Create the user command in Neovim
vim.api.nvim_create_user_command("ConvertCase", convertCaseWrapper, {range = true})
