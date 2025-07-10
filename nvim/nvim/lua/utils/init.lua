local M = {}

local uv = vim.loop

function M.require_all_in_dir(dir, exclude)
  exclude = exclude or {}
  local handle = uv.fs_scandir(dir)
  if not handle then return end

  while true do
    local name, _ = uv.fs_scandir_next(handle)
    if not name then break end
    if name:match("%.lua$") and not vim.tbl_contains(exclude, name) then
      local mod_name = name:sub(1, -5) -- remove '.lua'
      pcall(require, mod_name)
    end
  end
end

return M
