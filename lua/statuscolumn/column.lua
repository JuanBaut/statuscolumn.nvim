local column = {}

column.linenumber = function()
  if vim.v.relnum == 2 then
    return "%#ColumnTertiary#" .. vim.v.lnum
  end
  if vim.v.relnum == 1 then
    return "%#ColumnSecondary#" .. vim.v.lnum
  end
  if vim.v.relnum == 0 then
    return "%#ColumnCurrent#" .. vim.v.lnum
  end
  return "%#ColumnDim#" .. vim.v.lnum
end

column.border = function()
  if vim.v.relnum == 2 then
    return "%#ColumnTertiary#🭰"
  end
  if vim.v.relnum == 1 then
    return "%#ColumnSecondary#🭰"
  end
  if vim.v.relnum == 0 then
    return "%#ColumnCurrent#🭰"
  end
  return "%#ColumnDim#🭰"
end

column.bootstrap = function()
  local result = ""

  result = column.linenumber() .. " " .. column.border()
  return "%s%=" .. result
end

return column
