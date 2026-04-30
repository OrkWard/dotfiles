-- Treesitter textobject keymaps (loaded after treesitter)
local function setup_keymaps()
  local ok, ts = pcall(require, 'nvim-treesitter.textobjects')
  if not ok then
    return
  end

  -- ]f/[f = Next/prev function
  vim.keymap.set('n', ']f', function()
    require('nvim-treesitter.textobjects.move').goto_next_start('@function.outer')
  end, { noremap = true, silent = true, desc = 'Next function' })

  vim.keymap.set('n', '[f', function()
    require('nvim-treesitter.textobjects.move').goto_previous_start('@function.outer')
  end, { noremap = true, silent = true, desc = 'Prev function' })

  -- Text objects
  vim.keymap.set({ 'x', 'o' }, 'if', function()
    require('nvim-treesitter.textobjects.select').select_textobject('@function.inner')
  end, { noremap = true, silent = true, desc = 'Inner function' })

  vim.keymap.set({ 'x', 'o' }, 'af', function()
    require('nvim-treesitter.textobjects.select').select_textobject('@function.outer')
  end, { noremap = true, silent = true, desc = 'Around function' })
end

-- Setup when treesitter is ready
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = setup_keymaps,
})

-- Also try immediate setup
vim.defer_fn(setup_keymaps, 100)