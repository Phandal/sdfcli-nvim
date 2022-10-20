local is_windows = vim.loop.os_uname().version:match('Windows')

local M = {}

M.win = nil

M.path_sep = package.config:sub(1, 1)

M.is_fs_root = function(path)
  if is_windows then
    return path:match('^%a:$')
  else
    return path == '/'
  end
end

M.file_exists = function(path)
  local _, err = vim.loop.fs_stat(path)
  return err == nil
end

M.create_win = function()
  local width = math.ceil(vim.o.columns / 1.8)
  local height = math.ceil(vim.o.lines / 1.8)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    anchor = 'NW',
    style = 'minimal',
    col = (math.ceil(vim.o.columns - width) / 2),
    row = (math.ceil(vim.o.lines - height) / 2),
  }

  if M.win and vim.api.nvim_win_is_valid(M.win) then
    M.win = vim.api.nvim_win_set_buf(M.win, bufnr)
  else
    M.win = vim.api.nvim_open_win(bufnr, true, win_opts)
    vim.api.nvim_win_set_option(M.win, 'winblend', 10)
  end

  -- Set buffer options
  vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
  vim.api.nvim_buf_set_option(bufnr, 'filetype', 'sdfcli-nvim')
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<CMD>quit<CR>', { silent = true, noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<ESC>', '<CMD>quit<CR>', { silent = true, noremap = true })

  return M.win, bufnr
end

M.write_to_win = function(bufnr, lines)
  vim.api.nvim_buf_set_option(bufnr, 'modifiable', true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
  vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
end

return M
