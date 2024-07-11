local column = require("statuscolumn.column")
local colors = require("statuscolumn.colors")
local statuscolumn = {}

local function defaults(options)
  return {
    gradient_hl = options.gradient_hl or "Constant",
  }
end

function statuscolumn.setup(options)
  statuscolumn.options = defaults(options)
  statuscolumn.init = column.bootstrap
  colors.init(statuscolumn.options.gradient_hl)

  -- Create an autocommand group
  local augroup = vim.api.nvim_create_augroup("StatusColumn", { clear = true })

  -- Set up autocommands for specific filetypes or buffer types
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = augroup,
    callback = function(ev)
      local bufnr = ev.buf
      -- Check if this is an editing buffer
      if vim.bo[bufnr].buftype == "" and vim.bo[bufnr].filetype ~= "" then
        vim.opt_local.relativenumber = true
        vim.opt_local.statuscolumn = "%!v:lua.require('statuscolumn').init()"
      else
        -- For non-editing buffers, clear the statuscolumn
        vim.opt_local.statuscolumn = ""
      end
    end,
  })
end

function statuscolumn.is_configured()
  return statuscolumn.options ~= nil
end

function statuscolumn.test_msg()
  vim.notify("Statuscolumn is loaded (test)")
end

statuscolumn.options = nil

return statuscolumn
