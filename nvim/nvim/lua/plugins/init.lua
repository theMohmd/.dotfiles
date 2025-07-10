print('hi')
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- import all files in plugins/
local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins/"
local plugin_files = vim.fn.glob(plugin_dir .. "*.lua", true, true)

local plugins = {}
for _, file in ipairs(plugin_files) do
  if not file:match("init%.lua$") then
    local mod = "plugins." .. vim.fn.fnamemodify(file, ":t:r")
    local ok, plugin = pcall(require, mod)
    if ok then
      if type(plugin) == "table" and plugin[1] then
        vim.list_extend(plugins, plugin)
      else
        table.insert(plugins, plugin)
      end
    end
  end
end

require("lazy").setup(plugins)
