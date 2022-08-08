local M = {}

-- Default options
local defaults = {
  -- Start here
}

M.checkSDFInstalled = function()
  if vim.fn.executable == 1 then
    return true
  else
    return false
  end
end

-- Setup function to setup the config
function M.setup(opts)
  M.opts = vim.tbl_deep_extend('force', {}, defaults, opts or {})
  M.opts.sdfInstalled = M.checkSDFInstalled()
  -- M.opts.sdfInstalled = true -- This is used for testing
end

M.setup()

return M
