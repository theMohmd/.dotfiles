local utils = require("snippets/utils")
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local s = ls.snippet
local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("typescript", {
  s("clg", {
    t("console.log(\"milog\", "), i(1, "data"), t(");")
  }),

  s( "xslp",--sleep 
  {
    t("await new Promise(e=>setTimeout(e,"),
    i(1,"4000"),
    t(")) //sleep"),
    i(0),
  }),

  s("$", {
    t("${"), i(1),t("}")
  }),
  s("`", {
    t("`${"), i(1),t("}`")
  }),

  s("xwuseget",
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
    fileName = f(utils.get_file_name),   -- Dynamically set the file name
    endpoint = i(2, '"api/endpoint"'), -- Input placeholder for endpoint
    -- finish = i(0)                  -- Final jump point
  }, { repeat_duplicates = true })
),
  s("xget",
  fmt([[
import {{ endpoints }} from "@/lib/constants/endpoints";
import fetchErrorHandling from "@/lib/helpers/fetchErrorHandling";
import fetchApi from "@/lib/services/fetchApi";
import {{ {TApi} }} from "@/lib/types/api.type";

export default async function {filename}(): Promise<{TApi}<{T}{finish}>> {{
	const res = await fetchApi({{
		uri: endpoints.{},
		init: {{ method: "GET" }},
  }});
	if (!res.ok) {{
		await fetchErrorHandling(res);
  }}
	return res.json();
}}
  ]],{
    i(1),
    T = i(3,"T"),
    TApi = c(2, {
      t("TApiRes"),
      t("TApiPaginatedRes"),
    }),
    -- Tdir = f(function()
    --   local t = rep(3)
    --   return t
    -- end),
    filename = f(utils.get_file_name),
    finish = i(0),
  },{ repeat_duplicates = true })
  ),

  s("xpost",
  fmt([[
import {{ endpoints }} from "@/lib/constants/endpoints";
import fetchErrorHandling from "@/lib/helpers/fetchErrorHandling";
import fetchApi from "@/lib/services/fetchApi";

async function {filename}(payload: {T}{finish}) {{
	const res = await fetchApi({{
		uri: endpoints{},
		init: {{
			method: "POST",
			body: JSON.stringify(payload),
    }},
  }});
	if (!res.ok) {{
		await fetchErrorHandling(res);
  }}
	return res.json();
}}

export default {filename};
  ]],{
    i(1),
    T = i(2,"T"),
    filename = f(utils.get_file_name),
    finish = i(0),
  },{ repeat_duplicates = true })
  ),

  s("xquery",
  fmt([[
import {{ useQuery }} from "@tanstack/react-query";

import {api} from "../services/{api}";

export const {keyname} = "{querykey}";
export default function {filename}(enabled?: boolean) {{
	const query = useQuery({{
		queryKey: [{keyname}],
		queryFn: {api},
		enabled,
	}});
	const {{ data, isLoading: isLoading{Key}, ...rest }} = query;
	return {{
		{key}: data?.data,
		totalRecords: data?.metadata.pagination.totalRecords,
		isLoading{Key},
		...rest,
  }};
}}
  ]],{
    keyname = f(function()
      local name = utils.get_file_name()
      return "queryKey" .. name:sub(4)
    end),

    querykey = f(function()
      local filename = utils.get_file_name()
      return utils.camel_to_kebab( utils.lower_first(filename:sub(7)))
    end),

    key = f(function()
      local filename = utils.get_file_name()
      return utils.lower_first(filename:sub(7))
    end),

    Key =  f(function()
      local filename = utils.get_file_name()
      return filename:sub(7)
    end),

    api = f(function()
      local name = utils.get_file_name()
      return "api" .. name:sub(4)
    end),

    filename = f(utils.get_file_name), 

  })
  ),

  s("xmutation",
  fmt([[
import {{ useMutation, useQueryClient }} from "@tanstack/react-query";

import {api} from "../services/{api}";

export const {filename} = () => {{
	const queryClient = useQueryClient();
	const {{ mutate, isPending }} = useMutation({{
		mutationFn: {api},
		onSuccess: () => {{
			queryClient.invalidateQueries({{ queryKey: [{1}] }});
		}},
	}});
	return {{ {mutate}: mutate, {isPending}: isPending }};
}};
  ]],{
    i(1),
    mutate = f(function()
      local name = utils.lower_first(utils.get_file_name():sub(4))
      return name
    end),                -- depends on node 1
    isPending = f(function()
      local name = "isPosting" .. utils.get_file_name():sub(8)
      return name
    end),
    api = f(function()
      local name = utils.get_file_name()
      return "api" .. name:sub(4)
    end),
    filename = f(utils.get_file_name), 

  })
  ),


})

--   s( "xget",--get api with axios
--   fmt([[
--   import axios from "axios";
--
--   //get {parentDir} {finish}
--   export type {fileName}InputType = {{ {1} }}
--   export type {fileName}OutputType = {2}
--
--   export const {fileName}
--   : ( input: {fileName}InputType ) => Promise<{fileName}OutputType>
--   = async ( input ) => {{
--     return axios
--     .get("http://127.0.0.1:{3}/api/{parentDir}", {{
--       params:{{{4}}},
--       headers:{{
--         "Content-Type": "application/json",
--         Accept: "application/json",
--         Authorization: "Bearer " + getCookie("token"),
--       }},
--     }})
--     .then(res=>res.data)
--   }}
--
--   ]],{
--     i(1),
--     i(2),
--     i(3),
--     i(4),
--     fileName = f(get_file_name),
--     parentDir = f(get_folder_name),
--     finish =i(0),
--   })
-- ),

--   s( "xdel",--delete api with axios
--   fmt([[
--   import axios from "axios";
--
--   //delete {parentDir} {finish}
--   export type {fileName}InputType = {{ id:number;{1} }}
--   export type {fileName}OutputType = {2}
--
--   export const {fileName}
--   : ( input: {fileName}InputType ) => Promise<{fileName}OutputType>
--   = async ( input ) => {{
--     return axios
--     .delete(`http://127.0.0.1:{3}/api/{parentDir}/${{input.id}}`, {{
--       headers:{{
--         "Content-Type": "application/json",
--         Accept: "application/json",
--         Authorization: "Bearer " + getCookie("token"),
--       }},
--     }})
--     .then(res=>res.data)
--   }}
--
--   ]],{
--     i(1),
--     i(2),
--     i(3),
--     fileName = f(get_file_name),
--     parentDir = f(get_folder_name),
--     finish =i(0),
--   })
-- ),

--     s( "xpatch",--patch api with axios
--     fmt([[
--     import axios from "axios";
--
--     //patch {parentDir} {finish}
--     export type {fileName}InputType = {{ {1} }}
--     export type {fileName}OutputType = {2}
--
--     export const {fileName}
--     : ( input: {fileName}InputType ) => Promise<{fileName}OutputType>
--     = async ( input ) => {{
--       return axios
--       .post("http://127.0.0.1:{3}/api/{parentDir}", input, {{
--         headers:{{
--           "Content-Type": "application/json",
--           Accept: "application/json",
--           Authorization: "Bearer " + getCookie("token"),
--         }},
--       }})
--       .then(res=>res.data)
--     }}
--
--     ]],{
--       i(1),
--       i(2),
--       i(3),
--       fileName = f(get_file_name),
--       parentDir = f(get_folder_name),
--       finish =i(0),
--     })
--   ),

--   s( "xpost",--post api with axios
--   fmt([[
--   import axios from "axios";
--
--   //post {parentDir} {finish}
--   export type {fileName}InputType = {{ {1} }}
--   export type {fileName}OutputType = {2}
--
--   export const {fileName}
--   : ( input: {fileName}InputType ) => Promise<{fileName}OutputType>
--   = async ( input ) => {{
--     return axios
--     .post("http://127.0.0.1:{3}/api/{parentDir}", input, {{
--       headers:{{
--         "Content-Type": "application/json",
--         Accept: "application/json",
--         Authorization: "Bearer " + getCookie("token"),
--       }},
--     }})
--     .then(res=>res.data)
--   }}
--
--   ]],{
--     i(1),
--     i(2),
--     i(3),
--     fileName = f(get_file_name),
--     parentDir = f(get_folder_name),
--     finish =i(0),
--   })
-- ),
