-- Set indentation settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Allow buffer to be hidden without saving changes
vim.opt.hidden = true

-- Set encoding and cursor settings
vim.opt.encoding = "utf-8"
vim.opt.cursorline = true

-- Default split behavior
vim.opt.splitbelow = true

-- Always show status line
vim.opt.laststatus = 2

require('plugins')

vim.keymap.set({'n', 'x', 'o'}, 'f', '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, 'F', '<Plug>(leap-backward)')

vim.keymap.set({'n', 'x'}, 'j', 'gj')
vim.keymap.set({'n', 'x'}, 'k', 'gk')
