# sdfcli=nvim

A wrapper for the [sdfcli](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_1489072409.html) java tool.

Based on [christopherwxyz's](https://marketplace.visualstudio.com/publishers/christopherwxyz) [NetSuiteSDF VSCode Extension](https://marketplace.visualstudio.com/items?itemName=christopherwxyz.netsuitesdf)

## Concept
1. Fully support the sdfcli tool
2. Modify the `deploy.xml` file automatically
3. Streamline the process of Netsuite development

## Prerequisites

You must have the `sdfcli` tool setup and configured on your `$PATH`.

- Neovim version 0.7.0+
- [sdfcli](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_1489072409.html) java tool

## Installation

To install you can use your favorite package manager.

**Packer**
```lua
return require('packer').startup(function(use)
  use 'Phandal/sfdcli-nvim'
end)
```

## Setup
Somewhere in your `init.lua` you must run the setup function:
```lua
require('sdfcli-nvim').setup({
  sdfcli_cmd = "/path/to/sdfcli"
});
```

The default options are as follows:
```lua
local defaults = {
  sdfcli_cmd = '/sdfcli/sdfcli.bat'
}
```
