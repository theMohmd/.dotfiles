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

local function copy(args)
  return args[1]
end

function capitalize_first(str)
  return str:sub(1,1):upper() .. str:sub(2)
end

function kebab_to_camel(str)
  return str:gsub("-(%a)", function(letter)
    return letter:upper()
  end):gsub("^(%a)", function(first)
  return first:lower()
end)
end

-- Function to get the folder name of the current file
local function get_folder_name()
  local current_file = vim.fn.expand('%') -- Get the full path of the current file
  local parent_directory_name = current_file:match(".-([^/]+)/[^/]*$")
  return parent_directory_name or "Unknown"
end
-- Function to get the base name of the current file
local function get_file_name()
  local full_path = vim.fn.expand('%:t') -- Get the file name including extension
  local name_without_extension = full_path:gsub("%..+$", "") -- Remove the extension
  return name_without_extension

end
ls.add_snippets("gitcommit", {
  ls.s("feat", { ls.t("feat: "), ls.i(1, "implement ") }),
  ls.s("fix", { ls.t("fix: "), ls.i(1, "refactor ") }),
  ls.s("fixrefactor", { ls.t("fix: refactor") }),
  ls.s("fixminor", { ls.t("fix: minor fix")}),
  ls.s("chore", { ls.t("chore: "), ls.i(1, "update description") }),
  ls.s("choreprettier", { ls.t("chore: run prettier")}),
  ls.s("docs", { ls.t("docs: "), ls.i(1, "update documentation") }),
  ls.s("refactor", { ls.t("refactor: "), ls.i(1, "code improvement") }),
  ls.s("test", { ls.t("test: "), ls.i(1, "add/update tests") }),
})

ls.add_snippets("typescriptreact", {

  s( "xsx", fmt("{{ xs:{1},md:{2} }}",{i(1),i(2)})),
  s( "xut", fmt("const t = useTranslations({1})",{i(1)})),
  s( "xt", fmt("{{t(\"{1}\")}}",{i(1)})),
  s( "xchildren", t("{ children }: PropsWithChildren")),
  s( "xbutton", fmt("<button type=\"button\" onClick={{ ()=> console.log({1}) }}> todo build </button>",{i(1,"data")})),
  s( "xblack", t("sx={{backgroundColor:\"black\"}}")),
  s( "xfcolumn", t("flexDirection=\"column\"")),
  s( "xitemscenter", t("alignItems=\"center\"")),
  s( "xjustifycenter", t("justifyContent=\"center\"")),
  s( "xoverhidden", t("overflow=\"hidden\"")),
  s( "xflex", t("display=\"flex\"")),
  s( "xrel", t("position=\"relative\"")),
  s( "xabs", t("position=\"absolute\"")),
  s( "xbutton", fmt("<button onClick={{()=>console.log({1})}}> todo build </button>",{i(1)})),
  s( "xuc", t({"\"use client\"",""})),
  s(
  "xcv",--x component without props
  fmt(
  [[
  export default function View{fileName}() {{
    return <div>{fileName}{1}</div>;
  }}
  ]],
  -- [[
  -- import {{ Box }} from "@mui/material";{1}
  --
  -- export default function {fileName}() {{
    --   return <Box>{fileName}</Box>;
    -- }}
    -- ]],
    {
      i(0),
      fileName = f(get_folder_name),
    }
    )
    ),
    s(
    "xcp",--x component without props
    fmt(
    [[
    {1}
    export default function Page{folder}() {{
      return <div>{folder}</div>;
    }}
    ]],
    -- [[
    -- import {{ Box }} from "@mui/material";{1}
    --
    -- export default function {fileName}() {{
      --   return <Box>{fileName}</Box>;
      -- }}
      -- ]],
      {
        i(0),
        folder = f(function() return capitalize_first(kebab_to_camel(get_folder_name())) end),
      }
      )
      ),

      s("xus", {
        t("const ["),
        i(1, "state"),
        t(", "),
        f(function(args)
          local word = args[1][1]  -- Get the word from the first placeholder
          return "set" .. word:sub(1, 1):upper() .. word:sub(2)  -- Capitalize and prepend "set"
        end, {1}),
        t("] = useState<"),
        i(2, "type"),
        t(">("),
        i(3, "initialValue"),
        t(");"),
      }),

      -- s("us", fmt("const [{}, set{setter}] = useState({})", {
      --   i(1, "value"),
      --   i(2, "initialValue"),
      --   setter = l(l._1:sub(1,1):upper() .. l._1:sub(2,-1))
      -- })),

      s(
      "xc",--x component without props
      fmt(
      [[
      export default function {fileName}() {{
        return <div>{fileName}{1}</div>;
      }}
      ]],
      -- [[
      -- import {{ Box }} from "@mui/material";{1}
      --
      -- export default function {fileName}() {{
        --   return <Box>{fileName}</Box>;
        -- }}
        -- ]],
        {
          i(0),
          fileName = f(get_file_name),
        })),
        s(
        "xca",--x arrow component without props
        fmt(
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
          fileName = f(get_file_name),
        }
        )
        ),
        s(
        "xcprop",--x component with props
        fmt(
        [[
        "use client"
        //{fileName} component{4}
        type {fileName}Props = {{
          {1} : {2}
        }};
        const {fileName} = ({{ {3} }} : {fileName}Props) => {{
          return (
          <div>{fileName}</div>
          )
        }};

        export default {fileName};
        ]],
        {
          i(1,(get_file_name())),
          i(2,f(get_file_name)),
          f(copy,1),
          i(0),
          fileName = f(get_file_name),
        }
        )
        ),
        s( "slp",--sleep 
        {
          t("await new Promise(e=>setTimeout(e,"),
          i(1,"4000"),
          t(")) //sleep"),
          i(0),
        }),
        s( "xfile", {--fileName
          f(get_file_name),
        }),
        s( "t",
        {
          t("t(\""),
          f(get_folder_name),
          t("."),
          i(1),
          t("\")"),
          i(0),
        }),
      })
      ls.add_snippets("typescript", {


        s("xuseget",
        fmt([[
        import useGet, {{ TGetHookWrapperProps }} from "@/lib/hooks/useGet";
        import {{ TApiRes }} from "@/lib/types/api.type";

        export type T{data}Params = never; // Record<"", string | string[]>
        export default function {fileName}(
        args: TGetHookWrapperProps<T{data}, T{data}Params> = {{}}
        ) {{
          args.queryOptions = {{
            ...args.queryOptions,
            // keepPreviousData: true,
            // queryKey: queryKeys,
          }};
          return useGet<TApiRes<T{data}>, T{data}, T{data}Params>({{
            endpoint: {endpoint},
            ...(args as any),
          }});
        }}
        ]], {
          data = i(1, "DataType"),        -- Input placeholder for data type
          fileName = f(get_file_name),   -- Dynamically set the file name
          endpoint = i(2, '"api/endpoint"'), -- Input placeholder for endpoint
          -- finish = i(0)                  -- Final jump point
        }, { repeat_duplicates = true })
        ),
        s( "clg", {--fileName
          t("console.log("),
          i(1),
          t(")"),
        }),
        s( "tclg", {--fileName
          t("then(res=>{console.log(res);return res})"),
        }),
        s( "xfile", {--fileName
          f(get_file_name),
        }),
        s( "xget",--get api with axios
        fmt([[
        import axios from "axios";

        //get {parentDir} {finish}
        export type {fileName}InputType = {{ {1} }}
        export type {fileName}OutputType = {2}

        export const {fileName}
        : ( input: {fileName}InputType ) => Promise<{fileName}OutputType>
        = async ( input ) => {{
          return axios
          .get("http://127.0.0.1:{3}/api/{parentDir}", {{
            params:{{{4}}},
            headers:{{
              "Content-Type": "application/json",
              Accept: "application/json",
              Authorization: "Bearer " + getCookie("token"),
            }},
          }})
          .then(res=>res.data)
        }}

        ]],{
          i(1),
          i(2),
          i(3),
          i(4),
          fileName = f(get_file_name),
          parentDir = f(get_folder_name),
          finish =i(0),
        })
        ),
        s( "xdel",--delete api with axios
        fmt([[
        import axios from "axios";

        //delete {parentDir} {finish}
        export type {fileName}InputType = {{ id:number;{1} }}
        export type {fileName}OutputType = {2}

        export const {fileName}
        : ( input: {fileName}InputType ) => Promise<{fileName}OutputType>
        = async ( input ) => {{
          return axios
          .delete(`http://127.0.0.1:{3}/api/{parentDir}/${{input.id}}`, {{
            headers:{{
              "Content-Type": "application/json",
              Accept: "application/json",
              Authorization: "Bearer " + getCookie("token"),
            }},
          }})
          .then(res=>res.data)
        }}

        ]],{
          i(1),
          i(2),
          i(3),
          fileName = f(get_file_name),
          parentDir = f(get_folder_name),
          finish =i(0),
        })
        ),
        s( "xfile", {--fileName
          f(get_file_name),
        }),

        s( "xpatch",--patch api with axios
        fmt([[
        import axios from "axios";

        //patch {parentDir} {finish}
        export type {fileName}InputType = {{ {1} }}
        export type {fileName}OutputType = {2}

        export const {fileName}
        : ( input: {fileName}InputType ) => Promise<{fileName}OutputType>
        = async ( input ) => {{
          return axios
          .post("http://127.0.0.1:{3}/api/{parentDir}", input, {{
            headers:{{
              "Content-Type": "application/json",
              Accept: "application/json",
              Authorization: "Bearer " + getCookie("token"),
            }},
          }})
          .then(res=>res.data)
        }}

        ]],{
          i(1),
          i(2),
          i(3),
          fileName = f(get_file_name),
          parentDir = f(get_folder_name),
          finish =i(0),
        })
        ),

        s( "xpost",--post api with axios
        fmt([[
        import axios from "axios";

        //post {parentDir} {finish}
        export type {fileName}InputType = {{ {1} }}
        export type {fileName}OutputType = {2}

        export const {fileName}
        : ( input: {fileName}InputType ) => Promise<{fileName}OutputType>
        = async ( input ) => {{
          return axios
          .post("http://127.0.0.1:{3}/api/{parentDir}", input, {{
            headers:{{
              "Content-Type": "application/json",
              Accept: "application/json",
              Authorization: "Bearer " + getCookie("token"),
            }},
          }})
          .then(res=>res.data)
        }}

        ]],{
          i(1),
          i(2),
          i(3),
          fileName = f(get_file_name),
          parentDir = f(get_folder_name),
          finish =i(0),
        })
        ),

        s( "slp",--sleep 
        {
          t("await new Promise(e=>setTimeout(e,"),
          i(1,"4000"),
          t(")) //sleep"),
          i(0),
        }),
      })
      ls.add_snippets("lua",{
        s("class", {
          -- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
          c(1, {
            t("public "),
            t("private "),
          }),
          t("class "),
          i(2),
          t(" "),
          c(3, {
            t("{"),
            -- sn: Nested Snippet. Instead of a trigger, it has a position, just like insertNodes. !!! These don't expect a 0-node!!!!
            -- Inside Choices, Nodes don't need a position as the choice node is the one being jumped to.
            sn(nil, {
              t("extends "),
              -- restoreNode: stores and restores nodes.
              -- pass position, store-key and nodes.
              r(1, "other_class", i(1)),
              t(" {"),
            }),
            sn(nil, {
              t("implements "),
              -- no need to define the nodes for a given key a second time.
              r(1, "other_class"),
              t(" {"),
            }),
          }),
          t({ "", "\t" }),
          i(0),
          t({ "", "}" }),
        }),
      })
