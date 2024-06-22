local module = require("statuscolumn.module")

local statuscolumn = {}

local function with_defaults(options)
  return {
    greet_msg = options.greet_msg or "I exist",
  }
end

function statuscolumn.setup(options)
  statuscolumn.options = with_defaults(options)
  vim.api.nvim_create_user_command("SGreet", statuscolumn.greet, {})
end

function statuscolumn.is_configured()
  return statuscolumn.options ~= nil
end

function statuscolumn.greet()
  if not statuscolumn.is_configured() then
    return
  end

  local greeting = module.greeting(statuscolumn.options.greet_msg)
  vim.api.nvim_create_autocmd("WinEnter", {
    callback = function()
      vim.notify(greeting)
    end,
  })
end

-- Another function that belongs to the public API. This one does not depend on
-- user configuration
function statuscolumn.generic_greet()
  vim.notify("This is a test")
end

statuscolumn.options = nil

return statuscolumn
