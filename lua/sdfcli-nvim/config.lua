local M = {}

-- Default options
local defaults = {
  sdfInstalled = false,
}

function M.checkSDFInstalled()
  return false
end

-- Setup function to setup the config
function M.setup(opts) 
  M.opts = vim.tbl_deep_extend("force", {}, defaults, opts or {});
end

M.setup()

return M
