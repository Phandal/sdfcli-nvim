local utils = require('lua.sdfcli-nvim.utils')
local path_sep = package.config:sub(1, 1)

describe('The remove_trailing_slash function', function ()
  it('should remove the uneeded slash', function()
    assert.equal('/Users/test', utils.remove_trailing_slash('/Users/test/'))
  end)

  it('should not remove anything', function()
    assert.equal('/Users/test', utils.remove_trailing_slash('/Users/test'))
  end)
end)

describe('The get_cwd function', function()
  it('should get the cwd', function()
    local cwd = vim.fn.expand('%:p:h') .. path_sep
    assert.equal(cwd, utils.get_cwd())
  end)
end)
