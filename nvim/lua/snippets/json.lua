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


ls.add_snippets("json", {
  s("\"",
    fmt(
      [["{}":"{}",
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(",\"",
    fmt(
      [[,"{}":"{}"
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s("{",
    fmt(
      [["{}":{{
        {}
      }},
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),

})
