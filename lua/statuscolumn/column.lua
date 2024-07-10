local column = {}

column.signs = function()
  return vim.v.virtnum
end

column.linenumber = function()
  if vim.v.relnum == 0 then
    return "%#SpecialChar#" .. vim.v.lnum
  end
  return "%#SignColumn#" .. vim.v.lnum
end

column.border = function()
  if vim.v.relnum == 0 then
    return "%#SpecialChar#┆"
  end
  return "%#SignColumn#│"
end

column.bootstrap = function()
  local result = ""
  result = column.linenumber() .. column.border()
  return "%s%=" .. result
end

return column
