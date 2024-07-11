local colors = {}

local function is_valid_hex(hex)
  return hex:match("^#%x%x%x%x%x%x$") ~= nil
end

function colors.highlight(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  if hl.fg then
    local hex_color = string.format("#%06x", hl.fg)
    return hex_color
  end
  return nil
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

  local step_r = (end_r - start_r) / 3
  local step_g = (end_g - start_g) / 3
  local step_b = (end_b - start_b) / 3

  local color1 = rgb_to_hex(math.floor(start_r + step_r), math.floor(start_g + step_g), math.floor(start_b + step_b))

  local color2 = rgb_to_hex(math.floor(end_r - step_r), math.floor(end_g - step_g), math.floor(end_b - step_b))

  return {
    closer_to_start = color1,
    closer_to_end = color2,
  }
end

function colors.init(hl)
  local start_color = colors.highlight(hl) or "#65bcff"
  local end_color = colors.highlight("SignColumn") or "#3b4261"

  local gradient = colors.gradient_two_steps(start_color, end_color)
  local light_color = gradient.closer_to_start
  local dark_color = gradient.closer_to_end

  vim.api.nvim_set_hl(0, "ColumnCurrent", { fg = start_color })
  vim.api.nvim_set_hl(0, "ColumnSecondary", { fg = light_color })
  vim.api.nvim_set_hl(0, "ColumnTertiary", { fg = dark_color })
  vim.api.nvim_set_hl(0, "ColumnDim", { fg = end_color })
end

return colors
