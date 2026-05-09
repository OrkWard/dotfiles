-- ================================== Plugins ==================================
vim.pack.add({
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/stevearc/conform.nvim.git",
	"https://github.com/tpope/vim-sleuth.git",
	"https://github.com/lukas-reineke/indent-blankline.nvim.git",
	"https://github.com/gbprod/substitute.nvim.git",
	"https://github.com/nvim-lualine/lualine.nvim.git",
	"https://github.com/smoka7/hop.nvim.git",
	"https://github.com/altermo/ultimate-autopair.nvim.git",
})

require("mini.pick").setup()
do
	local pick = require("mini.pick")

	local function buffers_recent(local_opts)
		local_opts = vim.tbl_deep_extend("force", { include_current = false, include_unlisted = false }, local_opts or {})
		local cur_buf = vim.api.nvim_get_current_buf()
		local infos = vim.fn.getbufinfo()
		local items = {}
		for _, info in ipairs(infos) do
			if (local_opts.include_unlisted or info.listed == 1) and (local_opts.include_current or info.bufnr ~= cur_buf) then
				local name = info.name ~= "" and vim.fn.fnamemodify(info.name, ":~:.") or "[No Name]"
				table.insert(items, { text = name, bufnr = info.bufnr, _lastused = info.lastused or 0 })
			end
		end

		table.sort(items, function(a, b) return a._lastused > b._lastused end)
		for _, item in ipairs(items) do
			item._lastused = nil
		end

		return pick.start({ source = { name = "Buffers", items = items, show = pick.default_show } })
	end

	local function files_recent(local_opts)
		local_opts = vim.tbl_deep_extend("force", { tool = nil }, local_opts or {})
		local mtime_cache = {}
		local function get_mtime(path, cwd)
			local full = vim.fs.is_absolute(path) and path or (cwd .. "/" .. path)
			local cached = mtime_cache[full]
			if cached ~= nil then return cached end
			local stat = vim.loop.fs_stat(full)
			local mtime = stat and stat.mtime and stat.mtime.sec or 0
			mtime_cache[full] = mtime
			return mtime
		end

		local match_recent = function(stritems, inds, query)
			if #query > 0 then return pick.default_match(stritems, inds, query) end
			local opts = pick.get_picker_opts() or {}
			local cwd = (opts.source and opts.source.cwd) or vim.fn.getcwd()
			local res = vim.list_slice(inds, 1, #inds)
			table.sort(res, function(a, b)
				return get_mtime(stritems[a], cwd) > get_mtime(stritems[b], cwd)
			end)
			return res
		end

		return pick.builtin.files(local_opts, { source = { match = match_recent } })
	end

	pick.registry.buffers = buffers_recent
	pick.registry.files = files_recent
end

require("nvim-surround").setup({})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
	},
})

require("ibl").setup({
	indent = { char = "│" },
})

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

require("hop").setup()

require("ultimate-autopair").setup({
	-- the split pair into three lines only triggers when no extra token between
	cr = {
		conf = {
			cond = function(fn, o)
				if fn.in_lisp() then return false end
				local prev = o.col > 1 and o.line:sub(o.col - 1, o.col - 1) or ""
				local nextc = o.line:sub(o.col, o.col)
				local pairs = { ["("] = ")", ["["] = "]", ["{"] = "}" }
				return pairs[prev] == nextc
			end,
		},
	},
})
