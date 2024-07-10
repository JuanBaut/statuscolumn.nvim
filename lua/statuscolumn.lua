local column = require("statuscolumn.column")

local statuscolumn = {}

local function with_defaults(options)
  return {
    default_config = options.default_config or true,
  }
end

function statuscolumn.setup(options)
  statuscolumn.options = with_defaults(options)
  statuscolumn.init = column.bootstrap

  vim.opt.relativenumber = true
  vim.o.statuscolumn = "%!v:lua.require('statuscolumn').init()"
end

function statuscolumn.is_configured()
  return statuscolumn.options ~= nil
end

-- Another function that belongs to the public API. This one does not depend on
-- user configuration
function statuscolumn.test_msg()
  vim.notify("Statuscolumn in loaded (test)")
end

statuscolumn.options = nil

return statuscolumn
