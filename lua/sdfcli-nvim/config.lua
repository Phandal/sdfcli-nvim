local M = {}

-- Default options
local defaults = {
  -- Start here
}

function M.checkSDFInstalled()
  if vim.fn.executable == 1 then
    return true
  else
    return false
  end
end

-- Setup function to setup the config
function M.setup(opts) 
  M.opts = vim.tbl_deep_extend("force", {}, defaults, opts or {});
  M.opts.sdfInstalled = M.checkSDFInstalled()
end

M.setup()

return M
