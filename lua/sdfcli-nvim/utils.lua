local is_windows = vim.loop.os_uname().version:match('Windows')

local M = {}

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

M.create_win = function(width, height)
  --return 0, 0
end

return M
