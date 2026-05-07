-- ================================== Keymaps ==================================
local map = vim.keymap.set
local opts = { noremap = true }

-- Leader
vim.g.mapleader = ' '

-- ================================== Core ==================================

map('n', 'U', '<C-r>', opts)
map('n', 'Y', 'y$', opts)
map('n', '~', 'g~', opts)

-- x/X Free
map('n', 'x', '<NOP>', opts)
map('n', 'X', '<NOP>', opts)

-- ================================== Search ==================================

-- <Esc> in normal mode clears search highlights
map('n', '<Esc>', '<Cmd>nohlsearch<CR>', opts)

-- ================================== Indent ==================================

-- Normal mode: >/< indent/unindent line (single tap)
-- Visual mode: stay in visual after indent
map('v', '>', '>gv', opts)
map('v', '<', '<gv', opts)

-- ================================== Format ==================================

-- == = Format line
-- =g = Format entire file (was gg=G)
-- = (visual) = Format selection
-- =q = Format to textwidth (was gq)
map('n', '==', '==', opts)
map('n', '=g', 'gg=G', opts)
map('n', '=q', 'gq', opts)

-- ================================== Join ==================================

-- <C-j> = Join without space (was gJ)
map('n', '<C-j>', 'gJ', opts)

-- ================================== Navigation (]/[) ==================================

-- ]n/[n = Next/prev search + select
-- ]N/[N = Next/prev search (goto only)
-- ]f/[f = Next/prev function
-- ]F/[F = Next/prev function + select
-- ]p/[p = Next/prev paragraph
-- ]P/[P = Next/prev paragraph + select
-- ]t/[t = Next/prev todo (cross-file)
-- ]T/[T = Next/prev todo + select
-- ]c/[c = Next/prev comment
-- ]C/[C = Next/prev comment + select
-- Will be configured with treesitter/textobject plugins

-- ================================== Case (g~ -> ~) ==================================

-- Vanilla g~, gu, gU freed - use ~ operator instead
map('n', 'g~', '<NOP>', opts)
map('n', 'gu', '<NOP>', opts)
map('n', 'gU', '<NOP>', opts)

-- ================================== Emacs-style ==================================

-- Insert mode + Command line
local emacs_maps = {
  ['<C-a>'] = '<Home>',
  ['<C-b>'] = '<Left>',
  ['<C-d>'] = '<Del>',
  ['<C-e>'] = '<End>',
  ['<C-f>'] = '<Right>',
  ['<C-n>'] = '<Down>',
  ['<C-p>'] = '<Up>',
  ['<M-b>'] = '<S-Left>',
  ['<M-f>'] = '<S-Right>',
}

for k, v in pairs(emacs_maps) do
  map('c', k, v, opts)
  map('i', k, v, opts)
end

-- ================================== Edit Config Files (z prefix) ==================================

map('n', 'zK', function()
  vim.cmd('edit ~/.config/nvim/lua/keymap.lua')
end, opts)
map('n', 'zP', function()
  vim.cmd('edit ~/.config/nvim/lua/plugin.lua')
end, opts)
map('n', 'zU', function()
  vim.cmd('edit ~/.config/nvim/lua/option.lua')
end, opts)

map('n', '<C-k>', function()
  vim.cmd('mksession! /tmp/Session.nvim | restart source /tmp/Session.nvim')
end, opts)

