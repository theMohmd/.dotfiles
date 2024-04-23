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

-- Function to get the base name of the current file
local function get_file_name()
    local full_path = vim.fn.expand('%:t') -- Get the file name including extension
    local name_without_extension = full_path:gsub("%..+$", "") -- Remove the extension
    print(name_without_extension)
    return name_without_extension

end
ls.add_snippets("typescriptreact", {
    s(
        "xc",--x component without props
        fmt(
            [[
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
    )
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
