require('lualine').setup {
  options = {
    icons_enabled = true,
    -- theme = 'auto',
    theme = {
      normal = { c = { bg = 'NONE' } },
      inactive = { c = { bg = 'NONE' } },
    },,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = { },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {{'mode',color={fg="#ffffff"}}},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {{
      require("noice").api.statusline.mode.get,
      cond = require("noice").api.statusline.mode.has,
      color = { fg = "#ff9e64" },
    }},
    lualine_y = {'tabs'},
    lualine_z = {{'location',color={fg="#ffffff"}}}
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
local var = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = { },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename',color={fg="#ffffff"}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {{'mode',color={fg="#ffffff"}}},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {{
      require("noice").api.statusline.mode.get,
      cond = require("noice").api.statusline.mode.has,
      color = { fg = "#ff9e64" },
    }},
    lualine_y = {'tabs'},
    lualine_z = {{'location',color={fg="#ffffff"}}}
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
