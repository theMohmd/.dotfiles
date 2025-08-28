require("snippets/mui")
require("snippets/git")
require("snippets/ts")
require("snippets/tsx")
require("snippets/lua")
require("snippets/json")

local utils = require("snippets/utils")
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

ls.snippets = {}

-- Universal snippets
ls.add_snippets("all", {
  s("xfile", {
    f(utils.get_file_name),
  }),

  s("xfolder", {
    f(utils.get_folder_name),
  }),
})
