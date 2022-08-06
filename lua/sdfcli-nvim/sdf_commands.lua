local config = require('sdfcli-nvim.config');

local M = {}

function M.create_project(opts)
  M.opts = vim.tbl_deep_extend("force", {}, config.opts, opts or {})
  if M.opts.sdfInstalled then
    print('sdfInstalled = true')
  else
    if config.checkSDFInstalled() then
      M.opts.sdfInstalled = true
    else
      print('Please make sure that `sdfcli` is your $PATH')
    end
  end
end

return M
