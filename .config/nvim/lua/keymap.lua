-- ================================== Keymaps ==================================
local map = vim.keymap.set
local opts = { noremap = true }

-- Leader
vim.g.mapleader = " "

-- ================================== Core ==================================

map("n", "U", "<C-r>", opts)
map("n", "Y", "y$", opts)
map("n", "~", "g~", opts)

-- x/X Free
map("n", "x", "<NOP>", opts)
map("n", "X", "<NOP>", opts)

-- =================================== Jump ==================================

map("n", 's', function()
	vim.cmd('HopChar2AC')
end)
map('n', 'S', function()
	vim.cmd('HopChar2BC')
end)

-- ================================== Search ==================================

map("n", "<Esc>", "<Cmd>nohlsearch<CR>", opts)

-- ================================== Indent ==================================

-- Normal mode: >/< indent/unindent line (single tap)
-- Visual mode: stay in visual after indent
map("v", ">", ">gv", opts)
map("v", "<", "<gv", opts)

-- ================================== Format ==================================

-- == -> Format line
map("n", "==", "==", opts)
-- =g -> Format entire file
map("n", "=g", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local conform = require("conform")
	local to_run = conform.list_formatters_to_run(bufnr)
	if #to_run > 0 then
		conform.format({ bufnr = bufnr })
	else
		local view = vim.fn.winsaveview()
		vim.cmd("normal! gg=G")
		vim.fn.winrestview(view)
	end
end)
-- =q -> Format to textwidth (was gq)
map("n", "=q", "gq", opts)

-- ================================== Join ==================================

-- <C-j> = Join without space (was gJ)
map("n", "<C-j>", "gJ", opts)

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

-- ================================= Exchange =====================================
map("n", "cx", function()
	require("substitute").operator()
end)
map("n", "cxx", function()
	require("substitute").line()
end)
map("n", "cX", function()
	require("substitute").eol()
end)
map("x", "X", function()
	require("substitute").visual()
end)

-- =================================== Surround ====================================
map("n", "xs", "<Plug>(nvim-surround-normal)")
map("n", "xss", "<Plug>(nvim-surround-normal-cur)")
map("n", "xS", "<Plug>(nvim-surround-normal-line)")
map("n", "xSS", "<Plug>(nvim-surround-normal-cur-line)")
map("v", "s", "<Plug>(nvim-surround-visual)")
map("v", "S", "<Plug>(nvim-surround-visual-line)")
map("n", "dm", "<Plug>(nvim-surround-delete)")
map("n", "cm", "<Plug>(nvim-surround-change)")
map("n", "cM", "<Plug>(nvim-surround-change-line)")

-- ================================== Case (g~ -> ~) ==================================

map("n", "g~", "<NOP>", opts)
map("n", "gu", "<NOP>", opts)
map("n", "gU", "<NOP>", opts)

-- ================================== Emacs-style ==================================

-- Insert mode + Command line
local emacs_maps = {
	["<C-a>"] = "<Home>",
	["<C-b>"] = "<Left>",
	["<C-d>"] = "<Del>",
	["<C-e>"] = "<End>",
	["<C-f>"] = "<Right>",
	["<C-n>"] = "<Down>",
	["<C-p>"] = "<Up>",
	["<M-b>"] = "<S-Left>",
	["<M-f>"] = "<S-Right>",
}

for k, v in pairs(emacs_maps) do
	map("c", k, v, opts)
	map("i", k, v, opts)
end

-- =============================== Picker ========================================
map("n", "<leader>p", function()
	MiniPick.builtin.files()
end)

map("n", "<leader>b", function()
	MiniPick.builtin.buffers()
end)

map("n", "<leader>f", function()
	MiniPick.builtin.grep()
end)

-- ================================== Edit Config Files (z prefix) ==================================

map("n", "zK", function()
	vim.cmd("edit ~/.config/nvim/lua/keymap.lua")
end)
map("n", "zP", function()
	vim.cmd("edit ~/.config/nvim/lua/plugin.lua")
end)
map("n", "zO", function()
	vim.cmd("edit ~/.config/nvim/lua/option.lua")
end)
map("n", "zC", function()
	vim.cmd("edit ~/.config/nvim/lua/command.lua")
end)
map("n", "zL", function()
	vim.cmd("edit ~/.config/nvim/ftplugin/" .. vim.bo.filetype .. ".lua")
end)
