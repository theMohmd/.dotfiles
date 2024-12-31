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
ls.add_snippets("typescriptreact", {
  s( "xsx", fmt("{{ xs:{1},md:{2} }}",{i(1),i(2)})),
  s( "xblack", t("sx={{backgroundColor:\"black\"}}")),
  s( "xfcolumn", t("flexDirection=\"column\"")),
  s( "xitemscenter", t("alignItems=\"center\"")),
  s( "xjustifycenter", t("justifyContent=\"center\"")),
  s( "xoverhidden", t("overflow=\"hidden\"")),
  s( "xflex", t("display=\"flex\"")),
  s( "xuc", fmt([["use client"
  ]],{})),
  s(
  "xc",--x component without props
  fmt(
  [[
  import {{ Box }} from "@mui/material";{1}

  export default function {fileName}() {{
    return <Box>{fileName}</Box>;
  }}
  ]],
  {
    i(0),
    fileName = f(get_file_name),
  }
  )
  ),
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
  "xcp",--x component with props
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
