-- ================================== Plugins ==================================
vim.pack.add({
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/stevearc/conform.nvim.git",
	"https://github.com/tpope/vim-sleuth.git",
	"https://github.com/lukas-reineke/indent-blankline.nvim.git",
	"https://github.com/gbprod/substitute.nvim.git",
	"https://github.com/nvim-lualine/lualine.nvim.git",
	"https://github.com/folke/flash.nvim",
})

-- mini.pick
require("mini.pick").setup()

-- nvim-surround
require("nvim-surround").setup({})

-- conform.nvim
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
	},
})

-- indent-blankline.nvim
require("ibl").setup()

-- substitute.nvim
require("substitute").setup()
do
	local colors = {
		yellow = "#dabb7e",
		red = "#d36151",
		orange = "#d3604f",
		blue = "#5b79e3",
		dark_blue = "#4a62db",
		purple = "#a449ab",
		violet = "#9294be",
		green = "#649f57",
		gold = "#ad6e25",
		cyan = "#3882b7",
		light_black = "#2e323a",
		gray = "#eaeaed",
		dark_gray = "#ebebec",
		light_gray = "#a2a3a7",
		blue_gray = "#d9dcea",
		faint_gray = "#efefef",
		linenr = "#b0b1b3",
		black = "#383a41",
		white = "#fafafa",
	}

	local zed_onelight = {
		normal = {
			a = { fg = colors.white, bg = colors.blue, gui = "bold" },
			b = { fg = colors.black, bg = colors.gray },
			c = { fg = colors.black, bg = colors.dark_gray },
		},
		insert = {
			a = { fg = colors.white, bg = colors.green, gui = "bold" },
			b = { fg = colors.black, bg = colors.gray },
			c = { fg = colors.black, bg = colors.dark_gray },
		},
		visual = {
			a = { fg = colors.white, bg = colors.purple, gui = "bold" },
			b = { fg = colors.black, bg = colors.gray },
			c = { fg = colors.black, bg = colors.dark_gray },
		},
		replace = {
			a = { fg = colors.white, bg = colors.red, gui = "bold" },
			b = { fg = colors.black, bg = colors.gray },
			c = { fg = colors.black, bg = colors.dark_gray },
		},
		command = {
			a = { fg = colors.white, bg = colors.orange, gui = "bold" },
			b = { fg = colors.black, bg = colors.gray },
			c = { fg = colors.black, bg = colors.dark_gray },
		},
		inactive = {
			a = { fg = colors.light_gray, bg = colors.faint_gray },
			b = { fg = colors.light_gray, bg = colors.faint_gray },
			c = { fg = colors.light_gray, bg = colors.faint_gray },
		},
	}

	require("lualine").setup({
		options = {
			theme = zed_onelight,
			component_separators = { left = "/", right = "/" },
			icons_enabled = false,
		},
	})
end

-- flash.nvim
require("flash").setup({
	modes = {
		char = { keys = { "f", "F", "t", "T", ";", "," } },
	},
})
