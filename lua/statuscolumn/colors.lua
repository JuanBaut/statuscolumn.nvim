local colors = {}

local function is_valid_hex(hex)
  return hex:match("^#%x%x%x%x%x%x$") ~= nil
end

function colors.highlight(name, option)
  if type(name) ~= "string" or (option ~= "fg" and option ~= "bg") then
    error("Invalid arguments. Usage: highlight(name: string, option: 'fg' | 'bg')")
  end
  local hl = vim.api.nvim_get_hl(0, { name = name })
  local color = hl[option]
  if not color then
    print("No " .. option .. " color found for highlight group: " .. name)
    return nil
  end
  local hex_color = string.format("#%06x", color)
  return hex_color
end

local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

local function rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

function colors.gradient_two_steps(start_hex, end_hex)
  assert(is_valid_hex(start_hex) and is_valid_hex(end_hex), "Invalid hex color")
  local start_r, start_g, start_b = hex_to_rgb(start_hex)
  local end_r, end_g, end_b = hex_to_rgb(end_hex)

  -- Adjust these factors to control how close the colors are to the end
  local factor1 = 0.6
  local factor2 = 0.9

  local color1 = rgb_to_hex(
    math.floor(start_r + (end_r - start_r) * factor1),
    math.floor(start_g + (end_g - start_g) * factor1),
    math.floor(start_b + (end_b - start_b) * factor1)
  )

  local color2 = rgb_to_hex(
    math.floor(start_r + (end_r - start_r) * factor2),
    math.floor(start_g + (end_g - start_g) * factor2),
    math.floor(start_b + (end_b - start_b) * factor2)
  )

  return {
    dark = color1,
    light = color2,
  }
end

function colors.init(hl)
  local primary = colors.highlight(hl, "fg") or "#65bcff"
  local secondary = colors.highlight("SignColumn", "fg") or "#3b4261"
  local background = colors.highlight("StatusLine", "bg") or "#131621"

  local numbers = colors.gradient_two_steps(primary, secondary)
  local border = colors.gradient_two_steps(primary, background)

  vim.api.nvim_set_hl(0, "ColumnBase0", { fg = secondary })
  vim.api.nvim_set_hl(0, "ColumnBase1", { fg = background })

  vim.api.nvim_set_hl(0, "Column0", { fg = primary })
  vim.api.nvim_set_hl(0, "Column1", { fg = numbers.dark })
  vim.api.nvim_set_hl(0, "Column2", { fg = numbers.light })

  vim.api.nvim_set_hl(0, "ColumnBorder0", { fg = primary })
  vim.api.nvim_set_hl(0, "ColumnBorder1", { fg = border.dark })
  vim.api.nvim_set_hl(0, "ColumnBorder2", { fg = border.light })
end

return colors
