# AI_README.md

This file provides guidance to AI when working with code in this repository.

## Overview

This is a modular Neovim configuration adapted from Kickstart.nvim. It uses lazy.nvim for plugin management and follows a strict separation of concerns.

## Architecture

```
init.lua              → Entry point, sets leader key, loads modules in order
lua/
  options.lua         → All vim.o.* and vim.opt.* editor settings
  keymaps.lua         → Keyboard mappings and autocommands
  lazy-bootstrap.lua  → Installs lazy.nvim plugin manager if missing
  lazy-plugins.lua    → Plugin specifications (currently template/empty)
  utils.lua           → Helper functions (e.g., .env file reader)
```

**Loading order**: leader key → options → keymaps → lazy-bootstrap → lazy-plugins

## Key Patterns

### Adding options
```lua
vim.o.option = value           -- Simple values
vim.opt.option = { ... }       -- Table/list values
```

### Adding keymaps
```lua
vim.keymap.set(mode, keys, action, { desc = 'Description' })
```

### Adding autocommands
```lua
vim.api.nvim_create_autocmd('Event', {
  desc = 'Description',
  group = vim.api.nvim_create_augroup('group-name', { clear = true }),
  callback = function() ... end,
})
```

### Adding plugins
In `lazy-plugins.lua`, add to the table passed to `require('lazy').setup()`:
```lua
{ 'owner/repo', opts = { ... } }
```

Or use modular approach with separate files in `lua/plugins/`:
```lua
require 'plugins.example'
```

### Environment variables
Create `.env` file in config root, then:
```lua
local utils = require('utils')
local value = utils.get_env('KEY_NAME')
```

## Plugin Management

Run `:Lazy` inside Neovim to open the plugin manager UI. Plugins are auto-installed on first launch via the bootstrap process.

## Current Keybindings

- `<Space>` is the leader key
- `<leader>y/p/P` - System clipboard yank/paste operations
- `<leader>q` - Open diagnostic quickfix list
- `<C-h/j/k/l>` - Navigate between split windows
- `<Esc>` - Clear search highlights (normal mode)
- `<Esc><Esc>` - Exit terminal mode

## Configuration Notes

- Nerd Font icons are disabled (`have_nerd_font = false` in init.lua)
- OS clipboard sync is commented out for performance (use leader+y/p instead)
- Indentation: 4 spaces, tabs converted to spaces
- Persistent undo is enabled
