local utils = require('sdfcli-nvim.utils')
local config = require('sdfcli-nvim.config')

local M = {}

M.info_display = function()
  local lines = {}
  table.insert(lines, '')
  table.insert(lines, ' Root Directory:')
  table.insert(lines, ('   ' .. (config.opts.project_dir or 'Not set!')))
  table.insert(lines, '')
  table.insert(lines, ' Environment:')
  table.insert(lines, ('   ' .. (config.opts.environment_name or 'Not set!')))
  utils.create_float(lines, {})
end

return M
