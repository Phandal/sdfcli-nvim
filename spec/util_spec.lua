local util = require('lua.sdfcli-nvim.utils')

describe('The remove_trailing_slash function', function ()
  it('should remove the uneeded slash', function()
    assert.equal('/Users/test', util.remove_trailing_slash('/Users/test/'))
  end)

  it('should not remove anything', function()
    assert.equal('/Users/test', util.remove_trailing_slash('/Users/test'))
  end)
end)
