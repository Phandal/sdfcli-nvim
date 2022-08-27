local config = require('sdfcli-nvim.config')
local utils = require('sdfcli-nvim.utils')
-- local ui = require('sdfcli-nvim.ui')

local M = {}

local bufnr
local win

local append_data = function(_, data)
  if vim.api.nvim_buf_is_valid(bufnr) and data then
    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
  end
end

M.preview_deployment = function()
  if not config.is_ready then
    return
  end

  if not config.opts.environment then
    config.set_environment()
  end

  --utils.clear_prompt()
  -- local lines = vim.fn.systemlist(config.opts.sdfcli_cmd .. ' preview -authid ' .. config.opts.environment .. ' -p ' .. config.opts.project_dir)
  bufnr = vim.api.nvim_create_buf(false, true)
  vim.cmd('botright vnew')
  win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, bufnr)
  vim.fn.jobstart({config.opts.sdfcli_cmd, 'preview', '-authid', config.opts.environment, '-p', config.opts.project_dir}, {
    on_stdout = append_data,
    on_stderr = append_data,
    stdout_buffered = true,
    stderr_buffered = true,
  })
  --ui.create_float(lines, {})
end

return M
