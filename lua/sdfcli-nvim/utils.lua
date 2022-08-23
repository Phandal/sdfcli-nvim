local loop = vim.loop

local M = {}

M.path_sep = package.config:sub(1, 1)

M.get_cwd = function()
  local cwd = loop.fs_realpath(loop.cwd())
  cwd = cwd .. M.path_sep
  return cwd
end

M.get_base_path = function(path)
  path = M.remove_trailing_slash(path)
  local index = path:match('^.*()' .. M.path_sep)
  if index then
    return path:sub(0, index)
  end
end

M.get_folder_name = function(path)
  path = M.remove_trailing_slash(path)
  local index = path:match('^.*()' .. M.path_sep)
  if index then
    return path:sub(index + 1)
  end
  return path
end

M.remove_trailing_slash = function(path)
  local new_path, _ = path:gsub(M.path_sep .. '$', '')
  return new_path
end

M.add_trailing_slash = function(path)
  local found_slash, _ = path:find(M.path_sep .. '$')
  if not found_slash then
    return path .. M.path_sep
  end
  return path
end

M.clear_prompt = function()
  vim.api.nvim_command('normal! :')
end

M.file_exists = function(path)
  local _, error = loop.fs_stat(path)
  return error == nil
end

M.info_log = function(msg)
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.INFO)
  end)
end

M.warn_log = function(msg)
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.WARN)
  end)
end

M.error_log = function(msg)
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.ERROR)
  end)
end

M.create_float = function(lines, opts)
  local buf = vim.api.nvim_create_buf(false, true)
  local width = 60
  local height = 7
  vim.api.nvim_buf_set_lines(buf, 0, 1, true, lines)
  local options = {
    relative = 'editor',
    width = width,
    height = height,
    col = math.ceil((vim.o.columns - width) / 2),
    row = math.ceil((vim.o.lines - height) / 2),
    anchor = 'NW',
    style = 'minimal',
  }
  options = vim.tbl_deep_extend('force', options, opts)
  local win = vim.api.nvim_open_win(buf, 0, options)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'filetype', 'sdfinfo')
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<CMD>bd<CR>', { silent = true, noremap = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<esc>', '<CMD>bd<CR>', { silent = true, noremap = true })
  vim.api.nvim_win_set_option(win, 'winblend', 10)
end

return M
