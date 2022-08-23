local M = {}

M.win = nil

M.create_float = function(lines, opts)
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.ceil(vim.o.columns * 0.8)
  local height = math.ceil(vim.o.lines * 0.8)

  for i, v in ipairs(lines) do
    lines[i] = ' ' .. v
  end

  vim.api.nvim_buf_set_lines(buf, -1, 1, false, lines)
  local options = {
    relative = 'editor',
    width = width,
    height = height,
    anchor = 'NW',
    style = 'minimal',
  }
  options = vim.tbl_deep_extend('force', options, opts)
  options.col = (math.ceil(vim.o.columns - options.width) / 2)
  options.row = (math.ceil(vim.o.lines - options.height) / 2)

  if M.win and vim.api.nvim_win_is_valid(M.win) then
    vim.api.nvim_win_set_buf(M.win, buf)
  else
    M.win = vim.api.nvim_open_win(buf, 0, options)
  end

  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'filetype', 'sdfinfo')
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<CMD>bd<CR>', { silent = true, noremap = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<esc>', '<CMD>bd<CR>', { silent = true, noremap = true })
  vim.api.nvim_win_set_option(M.win, 'winblend', 10)
end

return M
