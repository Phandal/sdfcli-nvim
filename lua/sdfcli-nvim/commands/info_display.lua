local ui = require('sdfcli-nvim.ui')
local config = require('sdfcli-nvim.config')

local M = {}

M.info_display = function()
  local lines = {}
  table.insert(lines, 'Root Directory:')
  table.insert(lines, (' ' .. (config.opts.project_dir or 'Not set!')))
  table.insert(lines, '')
  table.insert(lines, 'Environment:')
  table.insert(lines, (' ' .. (config.opts.environment_name or 'Not set!')))
  local opts = { width = 60, height = 7 }
  ui.create_float(lines, opts)
end

return M
