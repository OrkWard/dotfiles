-- ================================== Plugins ==================================
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Theme: Zed OneLight (converted from Helix theme)
  {
    dir = vim.fn.stdpath('config'),
    config = function()
      vim.cmd('colorscheme zed_onelight')
    end
  },

  -- Statusline (replaces airline)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', optional = true },
    config = function()
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
          a = { fg = colors.white, bg = colors.blue, gui = 'bold' },
          b = { fg = colors.black, bg = colors.gray },
          c = { fg = colors.black, bg = colors.dark_gray },
        },
        insert = {
          a = { fg = colors.white, bg = colors.green, gui = 'bold' },
          b = { fg = colors.black, bg = colors.gray },
          c = { fg = colors.black, bg = colors.dark_gray },
        },
        visual = {
          a = { fg = colors.white, bg = colors.purple, gui = 'bold' },
          b = { fg = colors.black, bg = colors.gray },
          c = { fg = colors.black, bg = colors.dark_gray },
        },
        replace = {
          a = { fg = colors.white, bg = colors.red, gui = 'bold' },
          b = { fg = colors.black, bg = colors.gray },
          c = { fg = colors.black, bg = colors.dark_gray },
        },
        command = {
          a = { fg = colors.white, bg = colors.orange, gui = 'bold' },
          b = { fg = colors.black, bg = colors.gray },
          c = { fg = colors.black, bg = colors.dark_gray },
        },
        inactive = {
          a = { fg = colors.light_gray, bg = colors.faint_gray },
          b = { fg = colors.light_gray, bg = colors.faint_gray },
          c = { fg = colors.light_gray, bg = colors.faint_gray },
        },
      }

      require('lualine').setup({
        options = {
          theme = zed_onelight,
          icons_enabled = false,
        }
      })
    end
  },

  -- Surround (replaces vim-surround)
  -- cm = change surround (was cs)
  -- ds = delete surround
  -- ys = add surround
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({})
      vim.keymap.set('n', 'ys', '<Plug>(nvim-surround-normal)')
      vim.keymap.set('n', 'yss', '<Plug>(nvim-surround-normal-cur)')
      vim.keymap.set('n', 'yS', '<Plug>(nvim-surround-normal-line)')
      vim.keymap.set('n', 'ySS', '<Plug>(nvim-surround-normal-cur-line)')
      vim.keymap.set('x', 'S', '<Plug>(nvim-surround-visual)')
      vim.keymap.set('x', 'gS', '<Plug>(nvim-surround-visual-line)')
      vim.keymap.set('n', 'ds', '<Plug>(nvim-surround-delete)')
      vim.keymap.set('n', 'cm', '<Plug>(nvim-surround-change)')
      vim.keymap.set('n', 'cM', '<Plug>(nvim-surround-change-line)')
    end
  },

  -- Sneak (s/S)
  {
    'justinmk/vim-sneak',
    keys = { 's', 'S' },
    config = function()
      vim.g['sneak#label'] = 1
      vim.g['sneak#use_ic_scs'] = 1
      vim.g['sneak#s_next'] = 0
    end
  },

  -- Exchange (cx)
  {
    'tommcdo/vim-exchange',
    keys = { 'cx', 'cxc', 'cxx', { 'X', mode = 'v' } },
  },

  -- Comment (<C-c> toggle)
  {
    'numToStr/Comment.nvim',
    keys = {
      { '<C-c>', mode = { 'n', 'v' } },
    },
    config = function()
      require('Comment').setup({
        toggler = {
          line = '<C-c>',
          block = '<C-c><C-c>',
        },
        opleader = {
          line = '<C-c>',
          block = '<C-c><C-c>',
        },
        mappings = {
          basic = true,
          extra = false,
        },
      })
    end
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
      },
      scope = {
        enabled = false,
      },
    }
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      local ok, configs = pcall(require, 'nvim-treesitter.configs')
      if not ok then
        return
      end
      configs.setup({
        ensure_installed = {},
        auto_install = true,
        highlight = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {},
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {},
            goto_previous_start = {},
          },
        },
      })
    end
  },

  -- Flash
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        search = { enabled = false },
        char = {
          enabled = true,
          jump_labels = false,
          highlight = { backdrop = false },
        },
      },
    },
    keys = {
      { 'f', mode = { 'n', 'x', 'o' } },
      { 'F', mode = { 'n', 'x', 'o' } },
      { 't', mode = { 'n', 'x', 'o' } },
      { 'T', mode = { 'n', 'x', 'o' } },
    },
  },
}, {
  ui = { border = 'rounded' }
})
