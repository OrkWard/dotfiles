-- ================================== Options ==================================
local opt = vim.opt

-- Indentation
opt.tabstop = 4 -- default 4
opt.expandtab = true -- default space
opt.shiftwidth = 0 -- follow ts
opt.softtabstop = -1 -- follow sw
opt.autoindent = true -- inherit indent from last line. this has no confict to
                      -- si / ci / inde
                      -- si / ci / inde is dumb and should not be used here

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Behavior
opt.hidden = true -- allow vim make a dirty buffer hidden, but not unloaded (not so clear)
opt.splitbelow = true -- sp default bellow
opt.splitright = true -- vsp default right
opt.laststatus = 2 -- always keep the statusline
opt.linebreak = true -- line warp
opt.virtualedit = 'block' -- vblock mode
opt.autoread = true -- re-read when focus
opt.ttimeoutlen = 50 -- timeout before escape string
opt.wildmode = 'longest:full,full' -- command complete mode

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.fillchars = {
  vert = '│',
  fold = '-',
  eob = '~',
  lastline = '@'
}

-- Session
opt.sessionoptions = 'buffers,curdir,folds'

-- UI
opt.termguicolors = true
opt.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50'

-- Keep cursor away from screen edges (scroll offset)
opt.scrolloff = 5      -- Keep 5 lines above/below cursor
opt.sidescrolloff = 10 -- Keep 10 columns left/right of cursor

-- Whitespace display
opt.list = true
opt.listchars = {
  tab = '▸ ',      -- nice arrow + space
  space = '·',     -- middle dot
  trail = '~',     -- trailing space
  extends = '⟩',
  precedes = '⟨'
}

-- Disable unused providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

