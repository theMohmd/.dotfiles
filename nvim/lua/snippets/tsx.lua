local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local utils = require("snippets/utils")

ls.filetype_extend("typescriptreact", { "typescript" })

ls.add_snippets("typescriptreact", {
  -- Array creation helper
  s("xarr", {
    t("Array.from({ length: "),
    i(1, "3"),
    t("}).map((_, i) => "),
    i(0),
    t(")"),
  }),

  -- API hook pattern
  s("useget",
    fmt([[const {{ {data}, {isLoading} }} = useGet{1}();]],
    {
      i(1),
      data = f(function(args)
        local hook_name = args[1][1]
        if hook_name then
          return utils.lower_first(hook_name:sub(7))
        end
        return "data"
      end, {1}),
      isLoading = f(function(args)
        return "isLoading" .. (args[1][1]:sub(7) or "")
      end, {1}),
    })
  ),

  -- Translation hooks
  s("xut", fmt("const t = useTranslations{1}(\"{2}\")", { i(1),i(2) })),
  s("xt", fmt("{{t(\"{1}\")}}", { i(1) })),

  -- Common React patterns
  s("xchildren", t("{ children }: PropsWithChildren")),
  s("xuc", t({ "\"use client\"", "" })),

  -- Development helpers
  s("xbutton", fmt("<button type=\"button\" onClick={{()=> console.log({1})}}> todo build </button>", { i(1, "data") })),
  s("xborder", t("border=\"1px solid red\"")),

  -- Page component (using folder name)
  s("xcp", fmt(
    [[
    {1}
    export default function Page{folder}() {{
      return <div>{folder}</div>;
    }}
    ]],
    {
      i(0),
      folder = f(function() 
        return utils.capitalize_first(utils.kebab_to_camel(utils.get_folder_name())) 
      end),
    }
  )),

  -- View component (using folder name)
  s("xcv", fmt(
    [[
    export default function View{fileName}() {{
      return <div>{fileName}{1}</div>;
    }}
    ]],
    {
      i(0),
      fileName = f(utils.get_file_name),
    }
  )),

  -- Regular component (using file name)
  s("xc", fmt(
    [[
    export default function {fileName}() {{
      return <div>{fileName}{1}</div>;
    }}
    ]],
    {
      i(0),
      fileName = f(utils.get_file_name),
    }
  )),

  -- Arrow function component
  s("xca", fmt(
    [[
    "use client"
    //{fileName} component{1}
    const {fileName} = () => {{
      return (
        <div>{fileName}</div>
      )
    }};
    export default {fileName};
    ]],
    {
      i(0),
      fileName = f(utils.get_file_name),
    }
  )),

  -- React hook form
  s("xform", fmt("const formMethods = useForm<{1}>({{ defaultValues: {{}} satisfies {copy} }});", { i(1,"Form"), copy= rep(1)})),

})
