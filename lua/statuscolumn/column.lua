local column = {}

column.lnum = function()
  if vim.v.relnum == 2 then
    return "%#ColumnTertiary#" .. vim.v.lnum
  end
  if vim.v.relnum == 1 then
    return "%#ColumnSecondary#" .. vim.v.lnum
  end
  if vim.v.relnum == 0 then
    return " " .. "%#ColumnCurrent#" .. vim.v.lnum
  end
  return "%#ColumnDim#" .. vim.v.lnum
end

column.relnum = function()
  if vim.v.relnum == 2 then
    return "%#ColumnTertiary#" .. vim.v.relnum
  end
  if vim.v.relnum == 1 then
    return "%#ColumnSecondary#" .. vim.v.relnum
  end
  if vim.v.relnum == 0 then
    return " " .. "%#ColumnCurrent#" .. vim.v.lnum
  end
  return "%#ColumnDim#" .. vim.v.relnum
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

column.bootstrap_lnum = function(options)
  local result = ""

  if not options.enable_border then
    result = column.lnum() .. " "
  else
    result = column.lnum() .. " " .. column.border()
  end

  return "%s%=" .. result
end

column.bootstrap_relnum = function(options)
  local result = ""

  if not options.enable_border then
    result = column.relnum() .. " "
  else
    result = column.relnum() .. " " .. column.border()
  end

  return "%s%=" .. result
end

return column
