local config = require('sdfcli-nvim.config');

local M = {}

function M.create_project(opts)
  M.opts = vim.tbl_deep_extend("force", {}, config.opts, opts or {})
  if (not M.opts.sdfInstalled) then
    print('Please make sure that `sdfcli` is your $PATH')
  end

  local projectPath = '';
  repeat
    projectPath = vim.fn.input('Enter the path to the project')
  until (projectPath ~= "")

  print('\n' .. projectPath)
end

return M
