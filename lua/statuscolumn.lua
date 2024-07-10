local statuscolumn = {}

local function with_defaults(options)
  return {
    default_config = options.default_config or false,
  }
end

function statuscolumn.setup(options)
  statuscolumn.options = with_defaults(options)
  vim.api.nvim_create_user_command("SGreet", statuscolumn.greet, {})
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
