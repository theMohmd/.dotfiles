local utils = require("utils")
local config_dir = debug.getinfo(1).source:match("@?(.*/)")
utils.require_all_in_dir(config_dir, {"init.lua"})
