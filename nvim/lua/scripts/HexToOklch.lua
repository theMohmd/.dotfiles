local function hex_to_oklch(hex)
    hex = hex:gsub("#", "")
    local has_alpha = #hex == 8
    local r, g, b, a = tonumber(hex:sub(1, 2), 16) / 255, tonumber(hex:sub(3, 4), 16) / 255, tonumber(hex:sub(5, 6), 16) / 255, has_alpha and tonumber(hex:sub(7, 8), 16) / 255 or 1

    local function srgb_to_linear(c)
        return c <= 0.04045 and (c / 12.92) or ((c + 0.055) / 1.055) ^ 2.4
    end
    r, g, b = srgb_to_linear(r), srgb_to_linear(g), srgb_to_linear(b)

    local x = r * 0.4124564 + g * 0.3575761 + b * 0.1804375
    local y = r * 0.2126729 + g * 0.7151522 + b * 0.0721750
    local z = r * 0.0193339 + g * 0.1191920 + b * 0.9503041

    local l_ = x * 0.818933 + y * 0.361866 + z * -0.128859
    local m_ = x * 0.032984 + y * 0.929311 + z * 0.036145
    local s_ = x * 0.048200 + y * 0.264366 + z * 0.633853

    local function cbrt(v)
        return v^(1/3)
    end

    local l, m, s = cbrt(l_), cbrt(m_), cbrt(s_)
    local okl = 0.210454 * l + 0.793617 * m - 0.004072 * s
    okl = okl * 100
    local oka = 1.977998 * l - 2.428592 * m + 0.450593 * s
    local okb = 0.025904 * l + 0.782771 * m - 0.808675 * s

    local c = math.sqrt(oka^2 + okb^2)
    local h = math.deg(math.atan2(okb, oka))
    if h < 0 then h = h + 360 end

    local function round(v)
        return v
        -- return math.floor(v * 1000 + 0.5) / 1000
    end

    if has_alpha then
        return string.format("oklch(%.3f%% %.3f %.3f / %.1f%%)", round(okl), round(c), round(h), round(a * 100))
    else
        return string.format("oklch(%.3f%% %.3f %.3f)", round(okl), round(c), round(h))
    end
end

local function parse_oklch(input)
    local L, C, H, A = input:match("oklch%(([%d%.]+)%%? ([%d%.]+) ([%d%.]+) ?/? ?([%d%.]*)%%?%)")
    if L and C and H then
        return tonumber(L) / 100, tonumber(C), tonumber(H), A ~= "" and tonumber(A) / 100 or 1
    end
    error("Invalid OKLCH format")
end

local function deg_to_rad(deg)
    return deg * math.pi / 180
end

local function oklch_to_srgb(L, C, H)
    local a = C * math.cos(deg_to_rad(H))
    local b = C * math.sin(deg_to_rad(H))
    
    local L_ = L + 0.3963377774 * a + 0.2158037573 * b
    local M_ = L - 0.1055613458 * a - 0.0638541728 * b
    local S_ = L - 0.0894841775 * a - 1.2914855480 * b
    
    local function oklab_to_linear(c)
        return c ^ 3
    end
    
    local L_lin = oklab_to_linear(L_)
    local M_lin = oklab_to_linear(M_)
    local S_lin = oklab_to_linear(S_)
    
    local r =  4.0767416621 * L_lin - 3.3077115913 * M_lin + 0.2309699292 * S_lin
    local g = -1.2684380046 * L_lin + 2.6097574011 * M_lin - 0.3413193965 * S_lin
    local b = -0.0041960863 * L_lin - 0.7034186147 * M_lin + 1.7076147010 * S_lin
    
    local function gamma_correct(c)
        return c <= 0.0031308 and 12.92 * c or 1.055 * (c ^ (1 / 2.4)) - 0.055
    end
    
    return {
        math.max(0, math.min(1, gamma_correct(r))),
        math.max(0, math.min(1, gamma_correct(g))),
        math.max(0, math.min(1, gamma_correct(b)))
    }
end

local function oklch_to_hex(input)
    local success, L, C, H, A = pcall(parse_oklch, input)
    if not success then
        error("Invalid OKLCH input format")
    end
    
    local rgb = oklch_to_srgb(L, C, H)
    local r = math.floor(rgb[1] * 255 + 0.5)
    local g = math.floor(rgb[2] * 255 + 0.5)
    local b = math.floor(rgb[3] * 255 + 0.5)
    local a = math.floor(A * 255 + 0.5)
    
    if A < 1 then
        return string.format("#%02X%02X%02X%02X", r, g, b, a)
    else
        return string.format("#%02X%02X%02X", r, g, b)
    end
end

local function replace_selected_color()
    local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
    local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))
    if start_row ~= end_row then return end 

    local line = vim.api.nvim_buf_get_lines(0, start_row - 1, start_row, false)[1]
    local match = line:sub(start_col, end_col)
    if not match:match("^#%x%x%x%x%x%x%x?%x?$") and not match:match("^oklch%(%d+%.?%d*%%?%s+[%d%.]+%s+[%d%.]+%s*/?%s*[%d%.]*%%?%)$") then return end

    local converted = match:sub(1, 1) == "#" and hex_to_oklch(match) or oklch_to_hex(match)
    local new_line = line:sub(1, start_col - 1) .. converted .. line:sub(end_col + 1)
    vim.api.nvim_buf_set_lines(0, start_row - 1, start_row, false, {new_line})
end

vim.api.nvim_create_user_command("HexToOklch", replace_selected_color, {range = true})
